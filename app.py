from flask import Flask, request, jsonify
import sqlite3
import requests
import os
import logging

app = Flask(__name__)
DATABASE_PATH = "ma_base1.sqlite"

# Configuration de base pour le logging
logging.basicConfig(level=logging.INFO)

def is_sql_question(question):
    keywords = ["nombre", "liste", "combien", "afficher", "clients", "âge", "sexe", "magasins","superieur", "inférieur","égale","facture","vente","email","facture","total","num tel","compteur","prefix",
    "suppix","avoirachat", "avoirvente","transfert","payment","paymentmode", "sale","espece","cheque","carte bancaire","cnam","assurance","pass cadeau","privilege","produit","archived","created","updated","marge","marque","prix","quantite",
    "reference", "barcode", "coloration", "description", "matiere", "fournisseur",]
    return any(word.lower() in question.lower() for word in keywords)

def generate_sql(question):
    endpoint = "https://api-inference.huggingface.co/models/defog/sqlcoder-7b"
    headers = {
        "Authorization": f"Bearer {os.environ['HUGGINGFACEHUB_API_TOKEN']}",
        "Content-Type": "application/json"
    }
    data = {"inputs": f"{question}"}
    
    logging.info(f"Tentative de génération SQL pour la question: '{question}'")
    logging.info(f"Endpoint Hugging Face: {endpoint}")
    # ATTENTION: Ne pas logguer le token complet en production !
    # logging.info(f"Authorization Header: {headers['Authorization']}") 
    logging.info(f"Données envoyées: {data}")

    try:
        response = requests.post(endpoint, headers=headers, json=data)
        response.raise_for_status() # Lève une exception pour les codes d'état HTTP 4xx/5xx

        # Log la réponse complète avant de tenter de la parser
        logging.info(f"Réponse brute de Hugging Face (statut {response.status_code}): {response.text}")

        # Tente de parser la réponse JSON
        json_response = response.json()
        logging.info(f"Réponse JSON parsée: {json_response}")

        # Vérifie le format de la réponse
        if isinstance(json_response, list) and len(json_response) > 0 and "generated_text" in json_response[0]:
            sql = json_response[0]["generated_text"]
            logging.info(f"SQL généré avec succès: {sql}")
            return sql
        else:
            logging.warning(f"Format de réponse inattendu de Hugging Face: {json_response}")
            return None

    except requests.exceptions.RequestException as e:
        logging.error(f"Erreur lors de la requête HTTP à Hugging Face: {e}")
        return None
    except ValueError as e: # Si la réponse n'est pas un JSON valide
        logging.error(f"Erreur de décodage JSON de la réponse Hugging Face: {e}")
        logging.error(f"Contenu de la réponse qui a échoué au décodage JSON: {response.text}")
        return None
    except Exception as e:
        logging.error(f"Une erreur inattendue est survenue dans generate_sql: {e}", exc_info=True)
        return None

def execute_sql(sql):
    try:
        conn = sqlite3.connect(DATABASE_PATH)
        conn.row_factory = sqlite3.Row
        cur = conn.cursor()
        cur.execute(sql)
        rows = cur.fetchall()
        conn.close()
        return [dict(row) for row in rows]
    except Exception as e:
        logging.error(f"Erreur SQL lors de l'exécution: {e}") # Ajout de logging ici aussi
        return f"Erreur SQL : {e}"

@app.route("/ask", methods=["POST"])
def ask():
    question = request.json.get("question", "")
    logging.info(f"Requête reçue pour la question: '{question}'")

    if is_sql_question(question):
        sql = generate_sql(question)
        If sql:
            result = execute_sql(sql)
            logging.info(f"SQL exécuté, résultat: {result}")
        else:
            result = "❌ Requête non générée."
            logging.warning("La génération SQL a échoué.")
        
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
    app.run(debug=True)
