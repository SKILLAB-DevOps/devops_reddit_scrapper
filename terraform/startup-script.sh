sudo apt update
curl -LsSf https://astral.sh/uv/install.sh | sh

/root/.local/bin/uv python install 3.13.8

mkdir -p /opt/devops
cd /opt/devops
git clone https://github.com/SKILLAB-DevOps/devops_reddit_scrapper.git
cd devops_reddit_scrapper
/root/.local/bin/uv venv

source /opt/devops/devops_reddit_scrapper/.venv/bin/activate

/root/.local/bin/uv pip install .

cat > /etc/systemd/system/reddit_scrapper.service << EOF
[Unit]
Description=The Reddit Scraper Service
After=network.target

[Service]
Type=simple
ExecStart= /opt/devops/devops_reddit_scrapper/.venv/bin/python /opt/devops/devops_reddit_scrapper/main.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable reddit_scrapper.service
systemctl start reddit_scrapper.service