from flask import Flask, request, jsonify
import sqlite3
import requests
import os


app = Flask(__name__)
DATABASE_PATH = "ma_base1.sqlite"

def is_sql_question(question):
    keywords = ["nombre", "liste", "combien", "afficher", "clients", "âge", "sexe", "magasins","superieur", "inférieur","égale","facture","vente","email","facture","total","num tel","compteur","prefix",
    "suppix","avoirachat", "avoirvente","transfert","payment","paymentmode", "sale","espece","cheque","carte bancaire","cnam","assurance","pass cadeau","privilege","produit","archived","created","updated","marge","marque","prix","quantite",
    "reference","barcode","coloration","description","matiere","fournisseur",]
    return any(word.lower() in question.lower() for word in keywords)

def generate_sql(question):
    endpoint = "https://api-inference.huggingface.co/models/defog/sqlcoder-7b"
    headers = {
        "Authorization": f"Bearer {os.environ['HUGGINGFACEHUB_API_TOKEN']}",
        "Content-Type": "application/json"
    }
    data = {"inputs": f"{question}"}
    response = requests.post(endpoint, headers=headers, json=data)

    try:
        return response.json()[0]["generated_text"]
    except Exception:
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
        return f"Erreur SQL : {e}"

@app.route("/ask", methods=["POST"])
def ask():
    question = request.json.get("question", "")
    if is_sql_question(question):
        sql = generate_sql(question)
        result = execute_sql(sql) if sql else "❌ Requête non générée."
        return jsonify({
            "type": "sql",
            "sql": sql,
            "result": result
        })
    else:
        return jsonify({
            "type": "general",
            "response": f"🤖 Je suis un chatbot général. Voici une réponse générique à votre question : {question}"
        })

if __name__ == "__main__":
    app.run(debug=True)
