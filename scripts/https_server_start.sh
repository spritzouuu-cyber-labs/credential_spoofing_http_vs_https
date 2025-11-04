# ===========================================================
#  Flask HTTPS Server — Credential Lab (TLS enabled)
# ===========================================================
# Same app as HTTP version, but served over TLS/SSL.
# Requires a certificate in ./certs/server.crt and ./certs/server.key
# ===========================================================

from flask import Flask, render_template, request
import os

# Base dir (one level above /scripts/)
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

app = Flask(
    __name__,
    template_folder=os.path.join(BASE_DIR, 'templates'),
    static_folder=os.path.join(BASE_DIR, 'static')
)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    u = request.form.get('username')
    p = request.form.get('password')
    print(f"[+] Received credentials -> Username: {u}, Password: {p}")
    return f"<h3>Thanks {u}! Credentials received over HTTPS.</h3>"

if __name__ == '__main__':
    cert_path = os.path.join(BASE_DIR, 'scripts', 'certs', 'server.crt')
    key_path  = os.path.join(BASE_DIR, 'scripts', 'certs', 'server.key')

    print(f"[i] Using certificate: {cert_path}")
    app.run(
        host='0.0.0.0',
        port=8443,
        debug=True,
        ssl_context=(cert_path, key_path)
    )
