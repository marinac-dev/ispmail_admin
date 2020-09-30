#!/bin/bash
# Colors :3
G='\033[1;32m' # Green
NC='\033[0m' # No Color

# Update OS
printf "${G}- Updating OS ${NC}\n"
sudo apt update -y && sudo apt upgrade -y

# Restart user login system service ssh session can experience laggy
# inputs after update and restarting systemd-logind solves this (usually)
# sudo systemctl restart systemd-logind

# os_mon for erlang
printf "${G}- Installing os_mon ${NC}\n"
sudo apt install erlang-os-mon -y

# For passwords
printf "${G}- Installing pwgen ${NC}\n"
sudo apt install pwgen -y

# Install PostgreSQL
printf "${G}- Installing PostgreSQL ${NC}\n"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update -y
sudo apt-get -y install postgresql-12

# Postfix and Postfix-PostgreSQL adapter
printf "${G}- Installing Postfix ${NC}\n"
sudo apt install postfix postfix-pgsql -y
sudo apt install apache2 php7.4 -y

# Rspamd e-mail processing system
printf "${G}- Installing Rspamd ${NC}\n"
sudo apt install rspamd -y

# Tool to test email delivery
printf "${G}- Installing SWAKS!! ${NC}\n"
sudo apt install swaks -y

# Full-featured IMAP mail client (console-based)
printf "${G}- Installing Mutt ${NC}\n"
sudo apt install mutt -y

# LetsEncrypt
printf "${G}- Installing LetsEncrypt certbot ${NC}\n"
sudo apt install certbot -y

# Dovecot and Dovecot-PostgreSQL adapter
printf "${G}- Installing Dovecot ${NC}\n"
sudo apt install dovecot-pgsql dovecot-pop3d dovecot-imapd dovecot-managesieved dovecot-lmtpd -y

# To avoid errors when downloading files using wget
printf "${G}- Installing CA certificates ${NC}\n"
sudo apt install ca-certificates -y

# Roundcube and Roundcube-PostgreSQL adapter
printf "${G}- Installing Roundcube ${NC}\n"
sudo apt install roundcube roundcube-pgsql roundcube-plugins roundcube-plugins-extra -y

# DKIM n stuff
printf "${G}- Installing DNS-utils ${NC}\n"
sudo apt install dnsutils -y
