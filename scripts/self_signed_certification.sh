#!/usr/bin/env python3
"""
===========================================================
Self-Signed Certificate Generator (Python Version)
===========================================================
Creates a TLS certificate and key inside /scripts/certs/
Used for Flask HTTPS labs.
-----------------------------------------------------------
Usage:
    python3 scripts/self_signed_certification.py
-----------------------------------------------------------
"""

import os
import subprocess

# --- Paths ------------------------------------------------
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
CERT_DIR = os.path.join(SCRIPT_DIR, "certs")
CERT_KEY = os.path.join(CERT_DIR, "server.key")
CERT_CRT = os.path.join(CERT_DIR, "server.crt")

# --- Ensure folder exists --------------------------------
os.makedirs(CERT_DIR, exist_ok=True)

# --- Command to generate certificate ----------------------
cmd = [
    "openssl", "req", "-x509", "-nodes", "-days", "365",
    "-newkey", "rsa:2048",
    "-keyout", CERT_KEY,
    "-out", CERT_CRT,
    "-subj", "/CN=localhost"
]

# --- Run OpenSSL ------------------------------------------
print(f"[*] Generating self-signed certificate in {CERT_DIR} ...")
try:
    subprocess.run(cmd, check=True)
    os.chmod(CERT_KEY, 0o600)
    print("\n[✓] Certificate and key successfully created.")
    print(f"    Certificate: {CERT_CRT}")
    print(f"    Key:         {CERT_KEY}")
except FileNotFoundError:
    print("[!] Error: OpenSSL is not installed.")
except subprocess.CalledProcessError:
    print("[!] Error: OpenSSL command failed.")

print("\n[i] Start your HTTPS server with:")
print("    python3 scripts/https_server_start.py")
print("    # Then open https://127.0.0.1:8443 (accept the browser warning)")
