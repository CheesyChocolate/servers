#!/bin/bash

# System: Ubuntu 22.04 LTS

# update system
apt update && apt upgrade -y

# install some tools
apt install htop tmux vnstat ufw neovim curl python3-certbot-dns-cloudflare ssl-cert-check -y

# custom bashrc
curl -L https://raw.githubusercontent.com/CheesyChocolate/servers/main/vps-startUp/bashrc -o ~/.bashrc

# custom sshd_config to prevent brute force attacks
curl -L https://raw.githubusercontent.com/CheesyChocolate/servers/main/vps-startUp/sshd_config -o /etc/ssh/sshd_config
systemctl restart sshd

# start and enable vnstat
systemctl start vnstat
systemctl enable vnstat

# install ufw, enable and configure
systemctl enable ufw
systemctl start ufw
ufw default deny
# ssh port
ufw allow 22
ufw limit ssh
# http ports
ufw allow 80
ufw allow 8080
ufw allow 8880
ufw allow 2052
ufw allow 2082
ufw allow 2086
ufw allow 2095
# https ports
ufw allow 443
ufw allow 2053
ufw allow 2083
ufw allow 2087
ufw allow 2096
ufw allow 8443
# panel port
ufw allow 40402
# random port
ufw allow 20202:30302/tcp
ufw allow 20202:30302/udp
ufw enable
