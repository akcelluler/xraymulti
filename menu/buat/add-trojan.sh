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
clear
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "TROJAN WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "TROJAN WS HTTP" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${RED}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
#notes	
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
t="trojan"
v="vmess"
l="vless"
s="shadowsock"
g="grpc"
#buatakun
sed -i '/#trojanws$/a\# '"$user $exp $hariini $uuid $t"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\# '"$user $exp $hariini $uuid $t $g"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

#buatlinktrojan
trojanlinkwstls="trojan://${uuid}@${domain}:443?path=/xraytrojanws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"
trojanlinkgrpc="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
systemctl restart xray.service
service cron restart
clear
echo -e ""
echo -e "======-XRAYS/TROJAN-GO-======"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : $tls"
echo -e "Port No TLS : $nontls"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws/grpc"
echo -e "Path        : /xraytrojanws/trojan-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "link trojan ws"
echo -e "${NC}${GREEN} ${trojanlinkws} ${NC}"
echo -e "========================="
echo -e "link trojan ws tls"
echo -e "${NC}${ORANGE} ${trojanlinkwstls} ${NC}"
echo -e "========================="
echo -e "link trojan grpc"
echo -e "${NC}${BLUE} ${trojanlinkgrpc} ${NC}"
echo -e "========================="
echo -e "AKCELL XRAY MULTI TROJAN-GO"
