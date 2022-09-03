#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
# Link Hosting Kalian
akcell="raw.githubusercontent.com/akcelluler/xraymulti/main/menu"

apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://${akcell}/backup/rclone.conf"
git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y

cat >/etc/msmtprc<<EOF
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user akcellulerofficial@gmail.com
from akcellulerofficial@gmail.com
password alvwqpqwjqqhzlso
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc

#download
cd /usr/bin
wget -O autobackup "https://${akcell}/backup/autobackup.sh"
wget -O backup "https://${akcell}/backup/backup.sh"
wget -O restore "https://${akcell}/backup/restore.sh"

chmod +x autobackup
chmod +x backup
chmod +x restore
cd
rm -f /root/set-br.sh
