#!/usr/bin/env bash
set -euo pipefail

# 1. Go to your projects folder
mkdir -p ~/cyberproject && cd ~/cyberproject

# 2. Move the repo to the cyberproject folder + go to the repository for creating the venv
if [ -d ~/credential_spoofing_http_vs_https ]; then
  mv ~/credential_spoofing_http_vs_https ~/cyberproject/
fi
cd ~/cyberproject/credential_spoofing_http_vs_https || {
  echo "❌ Repository directory not found — check that cloning succeeded."
  exit 1
}

# 3. Update system and install Python + Wireshark essentials
echo "🔧 Installing system dependencies..."
sudo apt update -qq
sudo apt install -y python3 python3-venv python3-pip wireshark tshark libcap2-bin >/dev/null

# 4. Create a virtual environment named 'venv'
echo "🐍 Creating virtual environment..."
if python3 -m venv venv; then
  echo "✅ Virtual environment created successfully."
else
  echo "❌ Failed to create virtual environment."
  exit 1
fi

# 5. Activate the virtual environment
if [ -f venv/bin/activate ]; then
  # shellcheck disable=SC1091
  source venv/bin/activate
  echo "✅ Virtual environment activated."
else
  echo "❌ Could not find venv/bin/activate — venv creation likely failed."
  exit 1
fi

# 6. Upgrade pip to the latest version
echo "⬆️  Upgrading pip..."
if ! pip install --upgrade pip >/dev/null; then
  echo "⚠️  Warning: pip upgrade failed."
fi

# 7. Install required dependencies if requirements.txt exists
if [ -f requirements.txt ]; then
  echo "📦 Installing Python dependencies..."
  if pip install -r requirements.txt; then
    echo "✅ Dependencies installed successfully."
  else
    echo "❌ Error installing dependencies. Check requirements.txt for version issues."
    exit 1
  fi
else
  echo "⚠️ No requirements.txt file found — skipping dependency installation."
fi

# 8. Validate venv and pip environment
if python3 -c "import sys; print(sys.prefix)" | grep -q "$(pwd)/venv"; then
  echo "✅ Verified: Python is running inside the virtual environment."
else
  echo "❌ Warning: venv activation check failed — ensure you're inside the venv."
  exit 1
fi

echo "------------------------------------------------------"
echo "🎉 Setup complete!"
echo "🧠 You're now in: $(pwd)"
echo "🐍 Virtual environment path: $(pwd)/venv"
echo "------------------------------------------------------"
echo "⚠️  If Wireshark GUI doesn't open, log out and log back in so group changes take effect."
