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
IZIN=$( curl ipinfo.io/ip | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Fuck You!!"
exit 0
fi
NUMBER_OF_CLIENTS=$(grep -c -E "^##### " "/etc/xray/configmultiakun.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo -e	"  NO ${GREEN}USER   ${RED}EXPIRED ${BLUE}Net${NC}"
        grep -E "^##### " "/etc/xray/configmultiakun.json" | cut -d ' ' -f 2-2 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^##### " "/etc/xray/configmultiakun.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^##### " "/etc/xray/configmultiakun.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^##### " "/etc/xray/configmultiakun.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^##### " "/etc/xray/configmultiakun.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
t="trojan"
v="vmess"
l="vless"
s="shadowsock"
g="grpc"
sed -i "/^##### $user $exp $hariini $uuid /,/^},{/d" /etc/xray/configmultiakun.json
sed -i "/^# $user $exp $hariini $uuid $t $g/,/^},{/d" /etc/xray/config.json
sed -i "/^## $user $exp $hariini $uuid $l $g/,/^},{/d" /etc/xray/config.json
sed -i "/^### $user $exp $hariini $uuid $v $g/,/^},{/d" /etc/xray/config.json
sed -i "/^#### $user $exp $hariini $uuid $s $g/,/^},{/d" /etc/xray/config.json
rm -f /etc/xray/vmess-$user-ws.json
rm -f /etc/xray/vmess-$user-wstls.json
rm -f /etc/xray/vmess-$user-grpc.json
rm -f /etc/xray/configws-vmess-$user-ws.json
rm -f /etc/xray/configsni-vmess-$user-ws.json
rm -f /etc/xray/configws-vmess-$user-wstls.json
rm -f /etc/xray/configsni-vmess-$user-wstls.json
rm -f /etc/xray/configws-vmess-$user-grpc.json
rm -f /etc/xray/configsni-vmess-$user-grpc.json
rm -f /home/vps/public_html/ss-ws-$user.txt
rm -f /home/vps/public_html/ss-grpc-$user.txt
rm -f /home/vps/public_html/xray-multiakun-$user.txt
rm -f /home/vps/public_html/config-multiakun-$user.txt
rm -f /home/vps/public_html/configws-multiakun-$user.txt
rm -f /home/vps/public_html/configsni-multiakun-$user.txt
rm -f /home/vps/public_html/configws-trojan-$user.txt
rm -f /home/vps/public_html/configsni-trojan-$user.txt
rm -f /home/vps/public_html/configws-vless-$user.txt
rm -f /home/vps/public_html/configsni-vless-$user.txt
rm -f /home/vps/public_html/configws-vmess-$user.txt
rm -f /home/vps/public_html/configsni-vmess-$user.txt
rm -f /home/vps/public_html/configws-ss-ws-$user.txt
rm -f /home/vps/public_html/configsni-ss-ws-$user.txt
rm -f /home/vps/public_html/configws-ss-grpc-$user.txt
rm -f /home/vps/public_html/configsni-ss-grpc-$user.txt
systemctl restart xray.service
service cron restart
clear
echo ""
echo "==============================="
echo -e "${NC}${GREEN}XRAY MULTI AKUN BERHASIL DI HAPUS${NC}"
echo "==============================="
echo "Username  : $user"
echo "Expired   : $exp"
echo "==============================="
echo "AKCELL MULTI AKUN"
sleep 3
clear
menu-hapus
