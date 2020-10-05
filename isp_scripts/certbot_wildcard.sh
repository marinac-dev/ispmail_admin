#!/bin/bash
# Colors :3
G='\033[1;32m' # Green
NC='\033[0m' # No Color

printf "${G}- Letsencrypt Certbot certificate install. ${NC}\n"
printf "${G}- For a wildcard certificate add '*' like in example below.${NC}\n"
printf "${G}- Example domain = domain.tld ${NC}\n"
printf "${G}- Script domain parameter = *.domain.tld ${NC}\n"

read -p 'E-mail: ' mailvar
read -p 'Domain: ' domainvar
sudo certbot certonly --manual --preferred-challenges=dns --email $mailvar --agree-tos -d $domainvar
