from flask import Flask, request, render_template_string

app = Flask(__name__)

html_form = """
<!DOCTYPE html>
<html>
  <head>
    <title>Login Page</title>
  </head>
  <body>
    <h2>Login</h2>
    <form action="/login" method="POST">
      <label>Username:</label>
      <input type="text" name="username"><br><br>
      <label>Password:</label>
      <input type="password" name="password"><br><br>
      <input type="submit" value="Login">
    </form>
  </body>
</html>
"""

@app.route('/')
def index():
    return html_form

@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('username')
    password = request.form.get('password')
    print(f"[+] Received credentials -> Username: {username}, Password: {password}")
    return f"<h3>Thanks {username}! Data received.</h3>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
