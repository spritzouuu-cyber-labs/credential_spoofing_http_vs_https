# ===========================================================
#  Flask HTTP Server — Credential Spoofing Demonstration
# ===========================================================
# This script starts a local HTTP web server that:
#   1️⃣ Serves a login form (index.html) through Flask.
#   2️⃣ Accepts credentials submitted from the form.
#   3️⃣ Displays them in the terminal to simulate interception.
#
# Structure:
#   credential_spoofing_http_vs_https/
#   ├── scripts/http_server_start.py   ← this file
#   ├── templates/index.html           ← login form
#   └── static/style.css               ← visual design
#
# ===========================================================

# Flask = web framework, render_template = loads HTML templates,
# request = reads POST data from forms.
from flask import Flask, render_template, request
import os

# ----------------------------------------
# Get the project root (one folder above /scripts)
# ----------------------------------------
# This ensures Flask can find the 'templates' and 'static' folders,
# even though this script is inside /scripts/.
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

# ----------------------------------------
# Create Flask application object
# ----------------------------------------
# We explicitly tell Flask where to find templates and static files.
app = Flask(
    __name__,
    template_folder=os.path.join(BASE_DIR, 'templates'),
    static_folder=os.path.join(BASE_DIR, 'static')
)

# ----------------------------------------
# Route: '/' → Display the login form
# ----------------------------------------
# When you visit http://127.0.0.1:8080/
# Flask sends the HTML file "index.html" from /templates/.
@app.route('/')
def index():
    return render_template('index.html')

# ----------------------------------------
# Route: '/login' → Handle form submission (POST)
# ----------------------------------------
# When the user submits the login form,
# Flask extracts the form data from the POST request.
@app.route('/login', methods=['POST'])
def login():
    # Retrieve username and password fields from the form.
    username = request.form.get('username')
    password = request.form.get('password')

    # Print them to the terminal (simulating credential capture).
    print(f"[+] Received credentials -> Username: {username}, Password: {password}")

    # Respond to the browser so the user knows something happened.
    return f"<h3>Thanks {username}! Credentials received.</h3>"

# ----------------------------------------
# Launch the web server
# ----------------------------------------
# - host='0.0.0.0' makes it accessible from any network interface.
# - port=8080 sets the port number.
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
