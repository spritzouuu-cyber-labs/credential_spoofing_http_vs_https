#!/usr/bin/env python3
# ===========================================================
# Flask HTTPS Server — Credential Lab (TLS Encrypted)
# ===========================================================
# This script launches the *same* web app as http_server_start.py,
# but uses HTTPS (TLS/SSL) to encrypt all communications.
#
# Educational goal:
#   - Demonstrate how TLS encrypts HTTP traffic.
#   - Show that intercepted packets no longer reveal credentials.
#
# Folder structure (relative to repo root):
#   credential_spoofing_http_vs_https/
#     ├── scripts/https_server_start.py
#     ├── scripts/certs/server.crt
#     ├── scripts/certs/server.key
#     ├── templates/index.html
#     └── static/style.css
# ===========================================================

from flask import Flask, render_template, request
import os

# -----------------------------------------------------------
# Get project root directory (one level above /scripts)
# -----------------------------------------------------------
# Same logic as the HTTP version — used to locate templates and static files.
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
TEMPLATES_DIR = os.path.join(BASE_DIR, 'templates')
STATIC_DIR    = os.path.join(BASE_DIR, 'static')

# -----------------------------------------------------------
# Certificate paths
# -----------------------------------------------------------
# HTTPS requires a certificate and a private key.
# These can be generated with scripts/self_signed_certification.sh.
CERT_DIR = os.path.join(BASE_DIR, 'scripts', 'certs')
CERT_CRT = os.path.join(CERT_DIR, 'server.crt')
CERT_KEY = os.path.join(CERT_DIR, 'server.key')

# -----------------------------------------------------------
# Create Flask application object
# -----------------------------------------------------------
app = Flask(__name__, template_folder=TEMPLATES_DIR, static_folder=STATIC_DIR)

# -----------------------------------------------------------
# Route 1: Display the login form (GET)
# -----------------------------------------------------------
@app.route('/')
def index():
    # When visiting https://127.0.0.1:8443/
    # Flask will render and return "index.html" from /templates.
    return render_template('index.html')

# -----------------------------------------------------------
# Route 2: Handle form submission (POST)
# -----------------------------------------------------------
@app.route('/login', methods=['POST'])
def login():
    # Retrieve credentials from the POST request
    username = request.form.get('username')
    password = request.form.get('password')

    # Print them to the console — still visible locally, but encrypted on the wire
    print(f"[HTTPS] Received credentials -> Username: {username}, Password: {password}")

    # Respond to the browser
    return f"<h3>Thanks {username}! Credentials received over HTTPS (encrypted).</h3>"

# -----------------------------------------------------------
# Launch the HTTPS server
# -----------------------------------------------------------
if __name__ == '__main__':
    print(f"[i] Templates folder : {TEMPLATES_DIR}")
    print(f"[i] Static folder    : {STATIC_DIR}")
    print(f"[i] Certificate used : {CERT_CRT}")
    print(f"[i] Key used         : {CERT_KEY}")
    print("[i] Starting Flask server on https://0.0.0.0:8443 ...")

    # The only difference vs HTTP: add the SSL context and use port 8443.
    app.run(
        host='0.0.0.0',
        port=8443,
        debug=True,
        ssl_context=(CERT_CRT, CERT_KEY)
    )
