#!/bin/bash

# System: Debian 11

# update system
apt update && apt upgrade -y

# install some tools
apt install htop vnstat ufw neovim curl python3-certbot-dns-cloudflare python3-certbot-nginx python3-certbot-dns-linode ssl-cert-check -y

# custom bashrc
echo  -e "PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
umask 022

export LS_OPTIONS='--color=auto'
eval '$(dircolors)'
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

set -o vi

alias s='systemctl'
alias j='journalctl -xe'

[[ -f /opt/vultr/vultr_app.sh ]] && . /opt/vultr/vultr_app.sh
" > /root/.bashrc

# custom sshd_config to prevent brute force attacks
# TODO


# start and enable vnstat
systemctl start vnstat
systemctl enable vnstat

# install ufw, enable and configure
systemctl enable ufw
systemctl start ufw
ufw enable
ufw default deny
ufw allow 22
ufw allow 80
ufw allow 443
ufw limit ssh
ufw allow 40402
ufw allow 20202:30302/tcp
ufw allow 20202:30302/udp

# install x-ui
bash <(curl -Ls https://raw.githubusercontent.com/NidukaAkalanka/x-ui-english/master/install.sh)

# install BBR
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh

# install certbot
systemctl stop nginx
echo "enter server domain or subdomain name"
read -r SERVER_DOMAIN_NAME
echo "enter email address"
read -r DEV_EMAIL_ADDRESS
certbot certonly --standalone --preferred-challenges http --agree-tos --email "$DEV_EMAIL_ADDRESS" -d "$SERVER_DOMAIN_NAME"
