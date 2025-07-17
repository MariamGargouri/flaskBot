from flask import Flask, request, jsonify
import sqlite3
import os
import logging
import requests # Importation pour les requêtes HTTP à l'API Gemini

app = Flask(__name__)
DATABASE_PATH = "ma_base1.sqlite"

# Configuration de base pour le logging
logging.basicConfig(level=logging.INFO)

# Variable globale pour stocker le schéma parsé de la base de données
table_header_schema_global = None

def parse_metadata_sql(metadata_file="metadata.sql"):
    """
    Parse le fichier metadata.sql pour extraire les informations de table et de colonne.
    Ce schéma sera envoyé à l'API Gemini.
    """
    try:
        with open(metadata_file, "r") as f:
            content = f.read()
        if not content.strip(): # Ajout d'une vérification si le fichier est vide après lecture
            logging.warning(f"Le fichier {metadata_file} est vide ou ne contient que des espaces blancs.")
            return ""
        logging.info("Schéma de la base de données parsé avec succès depuis metadata.sql.")
        return content
    except FileNotFoundError:
        logging.error(f"metadata.sql non trouvé à {metadata_file}. Assurez-vous que le fichier existe et est accessible.")
        return ""
    except Exception as e:
        logging.error(f"Erreur lors de l'analyse de metadata.sql: {e}", exc_info=True)
        return ""

# --- DÉPLACER L'INITIALISATION ICI ---
# Parse metadata.sql une seule fois au démarrage du module, quel que soit le mode d'exécution.
table_header_schema_global = parse_metadata_sql()
if not table_header_schema_global:
    logging.error("Échec du chargement du schéma de la base de données au démarrage. L'API Gemini ne pourra pas générer de SQL.")
# --- FIN DU DÉPLACEMENT ---


def call_gemini_api(question, table_metadata_string):
    """
    Appelle l'API Gemini pour générer une requête SQL à partir de la question
    et des métadonnées de la table.
    """
    api_key = os.environ.get('GOOGLE_API_KEY')
    if not api_key:
        logging.error("GOOGLE_API_KEY n'est pas définie dans les variables d'environnement.")
        return None

    # Utilisez le modèle 'gemini-1.5-flash' pour une bonne performance et un coût potentiellement plus faible
    # L'URL de l'API Gemini pour la génération de contenu
    api_url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key={api_key}"

    # Construisez le prompt pour Gemini.
    # Il est crucial de donner des instructions claires et le schéma de la base de données.
    prompt_text = f"""
    You are a powerful text-to-SQL model. Your task is to translate a user question into a SQL query, given the database schema.
    You must output ONLY the SQL query, and nothing else. Do not include any explanations, comments, or additional text.

    ### Instructions:
    - Generate a SQL query that directly answers the user's question.
    - Use the provided table metadata to understand the database schema.
    - Ensure the generated SQL is syntactically correct for SQLite.

    ### User Question:
    {question}

    ### Table Metadata:
    {table_metadata_string}

    ### SQL Query:
    """

    headers = {
        'Content-Type': 'application/json',
    }
    payload = {
        "contents": [
            {
                "role": "user",
                "parts": [
                    {"text": prompt_text}
                ]
            }
        ],
        # Vous pouvez ajouter des paramètres de génération ici si nécessaire, par exemple:
        # "generationConfig": {
        #     "temperature": 0.1, # Température basse pour des résultats déterministes
        #     "maxOutputTokens": 500 # Limite la longueur de la réponse
        # }
    }

    logging.info("Envoi de la requête à l'API Gemini...")
    try:
        response = requests.post(api_url, headers=headers, json=payload, timeout=30) # Ajout d'un timeout
        response.raise_for_status() # Lève une exception pour les codes d'état HTTP 4xx/5xx (ex: 400, 401, 403, 429)
        
        json_response = response.json()
        logging.info(f"Réponse brute de l'API Gemini: {json_response}")
        
        # Extrait le texte généré par Gemini
        if json_response and json_response.get('candidates') and len(json_response['candidates']) > 0:
            generated_text = json_response['candidates'][0]['content']['parts'][0]['text']
            # Nettoyez la sortie si Gemini inclut des backticks (```sql) ou d'autres textes non SQL
            # Ceci est très important car Gemini peut être "bavard"
            sql_query = generated_text.split("```sql")[-1].split("```")[0].strip()
            # Si le modèle ne met pas de backticks, assurez-vous de ne pas couper la requête
            if not sql_query: # Si le split a échoué, prenez tout le texte généré
                sql_query = generated_text.strip()

            logging.info(f"Requête SQL générée par Gemini (nettoyée): {sql_query}")
            return sql_query
        else:
            logging.warning(f"Réponse inattendue de l'API Gemini (pas de candidats ou de contenu): {json_response}")
            return None

    except requests.exceptions.Timeout:
        logging.error("La requête à l'API Gemini a expiré.")
        return None
    except requests.exceptions.RequestException as e:
        logging.error(f"Erreur lors de l'appel à l'API Gemini: {e}", exc_info=True)
        return None
    except Exception as e:
        logging.error(f"Erreur inattendue lors du traitement de la réponse Gemini: {e}", exc_info=True)
        return None

# --- Fonctions existantes de l'API Flask ---
def is_sql_question(question):
    """
    Détermine si une question est susceptible d'être une question SQL
    en fonction de mots-clés prédéfinis.
    """
    keywords = ["nombre", "liste", "combien", "afficher", "clients", "âge", "sexe", "magasins","superieur", "inférieur","égale","facture","vente","email","facture","total","num tel","compteur","prefix",
    "suppix","avoirachat", "avoirvente","transfert","payment","paymentmode", "sale","espece","cheque","carte bancaire","cnam","assurance","pass cadeau","privilege","produit","archived","created","updated","marge","marque","prix","quantite",
    "reference","barcode","coloration","description","matiere","fournisseur",]
    return any(word.lower() in question.lower() for word in keywords)

def execute_sql(sql):
    """
    Exécute une requête SQL sur la base de données SQLite.
    """
    try:
        conn = sqlite3.connect(DATABASE_PATH)
        conn.row_factory = sqlite3.Row # Permet d'accéder aux colonnes par leur nom
        cur = conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()
        conn.close()
        return [dict(row) for row in rows] # Convertit les lignes en dictionnaires
    except Exception as e:
        logging.error(f"Erreur SQL lors de l'exécution de la requête: {e}")
        return f"Erreur SQL : {e}"

@app.route("/ask", methods=["POST"])
def ask():
    """
    Point d'entrée de l'API pour les questions.
    Détecte si la question est SQL et génère/exécute le SQL si c'est le cas.
    """
    question = request.json.get("question", "")
    logging.info(f"Requête reçue pour la question: '{question}'")

    if is_sql_question(question):
        # Récupérez le schéma de la base de données (déjà parsé au démarrage)
        if not table_header_schema_global:
            logging.error("Schéma de base de données non disponible. Impossible de générer SQL.")
            return jsonify({"type": "sql", "sql": None, "result": "❌ Schéma de base de données non chargé."})
            
        # Utilise la fonction pour appeler Gemini
        sql = call_gemini_api(question, table_header_schema_global)

        if sql: # Cette ligne est correctement indentée.
            result = execute_sql(sql)
            logging.info(f"SQL exécuté, résultat: {result}")
        else:
            result = "❌ Requête non générée par Gemini."
            logging.warning("La génération SQL par Gemini a échoué.")
        
        return jsonify({
            "type": "sql",
            "sql": sql,
            "result": result
        })
    else:
        logging.info(f"Question non SQL détectée: '{question}'")
        return jsonify({
            "type": "general",
            "response": f"🤖 Je suis un chatbot général. Voici une réponse générique à votre question : {question}"
        })

if __name__ == "__main__":
    # Ce bloc n'est plus nécessaire pour initialiser table_header_schema_global
    # car cela est fait au niveau du module.
    # Il est conservé pour l'exécution locale si debug=True.
    app.run(debug=True)

