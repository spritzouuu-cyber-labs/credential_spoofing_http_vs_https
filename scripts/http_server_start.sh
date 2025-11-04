#!/usr/bin/env python3
# ===========================================================
# Flask HTTP Server — Credential Lab (Unencrypted)
# ===========================================================
# This script launches a simple web server using Flask that:
#   1. Displays a login form from /templates/index.html
#   2. Accepts credentials submitted via POST
#   3. Prints them in the terminal (simulating credential capture)
#
# Educational goal:
#   - Demonstrate that HTTP transmits credentials in plaintext.
#   - Observe them in Wireshark when captured on port 8080.
#
# Folder structure (relative to repo root):
#   credential_spoofing_http_vs_https/
#     ├── scripts/http_server_start.py
#     ├── templates/index.html
#     └── static/style.css
# ===========================================================

from flask import Flask, render_template, request
import os

# -----------------------------------------------------------
# Get project root directory (one level above /scripts)
# -----------------------------------------------------------
# This ensures Flask can locate the "templates" and "static" folders.
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
TEMPLATES_DIR = os.path.join(BASE_DIR, 'templates')
STATIC_DIR    = os.path.join(BASE_DIR, 'static')

# -----------------------------------------------------------
# Create Flask application object
# -----------------------------------------------------------
# render_template() loads HTML files from /templates
# static_folder serves CSS, JS, and images from /static
app = Flask(__name__, template_folder=TEMPLATES_DIR, static_folder=STATIC_DIR)

# -----------------------------------------------------------
# Route 1: Display the login form (GET)
# -----------------------------------------------------------
@app.route('/')
def index():
    # When visiting http://127.0.0.1:8080/
    # Flask will render and return "index.html" from the templates folder.
    return render_template('index.html')

# -----------------------------------------------------------
# Route 2: Handle form submission (POST)
# -----------------------------------------------------------
@app.route('/login', methods=['POST'])
def login():
    # Extract username and password from the submitted form
    username = request.form.get('username')
    password = request.form.get('password')

    # Print them to the console to simulate interception
    print(f"[HTTP] Received credentials -> Username: {username}, Password: {password}")

    # Respond to the user (for confirmation)
    return f"<h3>Thanks {username}! Credentials received over HTTP (unencrypted).</h3>"

# -----------------------------------------------------------
# Launch the HTTP server
# -----------------------------------------------------------
if __name__ == '__main__':
    print(f"[i] Templates folder : {TEMPLATES_DIR}")
    print(f"[i] Static folder    : {STATIC_DIR}")
    print("[i] Starting Flask server on http://0.0.0.0:8080 ...")
    # Port 8080 = HTTP (no encryption)
    app.run(host='0.0.0.0', port=8080, debug=True)
