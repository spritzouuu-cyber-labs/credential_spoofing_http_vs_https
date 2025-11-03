# 1. Go to your projects folder
mkdir -p ~/cyberproject && cd ~/cyberproject

# 2. Clone the repo
git clone https://github.com/spritzouuu-cyber-labs/credential_spoofing_http_vs_https
cd credential_spoofing_http_vs_https

# 3. Update system and install Python essentials
sudo apt update && sudo apt install -y python3 python3-venv python3-pip

# 4. Create a virtual environment named 'venv'
python3 -m venv venv

# 5. Activate the virtual environment
source venv/bin/activate

# 6. Upgrade pip to the latest version
pip install --upgrade pip

# 7. Install required dependencies if requirements.txt exists
[ -f requirements.txt ] && pip install -r requirements.txt

echo "✅ Setup complete! Virtual environment activated and dependencies installed."
