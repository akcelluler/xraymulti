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
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "VLESS HTTP" | cut -d: -f2|sed 's/ //g')"
bugws="$(cat /etc/xray/bugws)"
bugsni="$(cat /etc/xray/bugsni)"
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^## " "/etc/xray/config.json")
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
        grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2,3,6,7 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
clear
#buatlinkvless
vlesslinkws="vless://${uuid}@${bugws}:80?path=/xrayws&security=none&encryption=none&host=${domain}&type=ws#${user}"
vlesslinkwstls="vless://${uuid}@${bugws}:443?path=/xrayws&security=tls&encryption=none&host=${domain}&type=ws&sni=${domain}#${user}"
vlesslinkgrpc="vless://${uuid}@${bugws}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"
clear
#buat text all link
cat > /home/vps/public_html/configws-vless-$user.txt<<EOF
${vlesslinkws}
${vlesslinkwstls}
${vlesslinkgrpc}
EOF
cd
clear
echo -e ""
echo -e "==========-CONFIG-VLESS-========"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : ${tls}"
echo -e "Port No TLS : ${nontls}"
echo -e "User ID     : ${uuid}"
echo -e "Alter ID    : 0"
echo -e "Security    : auto"
echo -e "Network     : ws/grpc"
echo -e "Path ws     : /xrayws"
echo -e "Path grpc   : vless-grpc"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "========================="
echo -e "link vless WS"
echo -e "${NC}${GREEN} ${vlesslinkws} ${NC}"
echo -e "========================="
echo -e "link vless WS tls"
echo -e "${NC}${ORANGE} ${vlesslinkwstls} ${NC}"
echo -e "========================="
echo -e "link vless grpc"
echo -e "${NC}${BLUE}${vlesslinkgrpc} ${NC}"
echo -e "========================="
echo -e "======Custom Import Config From URL ======="
echo -e "URL CONFIG V2RAYNG vless : ${NC}${RED} http://${domain}:89/configws-vless-$user.txt ${NC}" 
echo -e "===================================================="
echo -e                "AKCELL XRAY MULTI VLESS"
echo -e "===================================================="
