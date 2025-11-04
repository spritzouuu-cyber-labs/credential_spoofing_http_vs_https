#!/usr/bin/env bash
# ===========================================================
# Generate a self-signed TLS certificate (inside /scripts/certs)
# Used for HTTPS Flask lab.
# ===========================================================

set -euo pipefail

# Ensure we are inside the scripts folder
cd "$(dirname "$0")"

# certs folder INSIDE scripts/
CERT_DIR="certs"
KEY="$CERT_DIR/server.key"
CRT="$CERT_DIR/server.crt"

mkdir -p "$CERT_DIR"

echo "[*] Generating self-signed certificate inside: $(pwd)/$CERT_DIR"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$KEY" -out "$CRT" \
  -subj "/CN=localhost"

chmod 600 "$KEY"

echo
echo "[✓] Done."
echo "    Cert : $CRT"
echo "    Key  : $KEY"
echo
echo "[→] Start your HTTPS server with:"
echo "    python3 scripts/https_server_start.py"
