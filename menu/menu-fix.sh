#!/bin/bash
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m                 INFO SERVER                \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m"
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
#clear
if [ "$cekup" = "day" ]; then
echo -e "System Uptime   :  $uphours $upminutes $uptimecek"
else
echo -e "System Uptime   :  $uphours $upminutes"
fi
echo -e "IP-VPS          :  $IPVPS"
echo -e "ISP-VPS         :  $ISPVPS"
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║                       ┃ Script By Akcell ┃                      ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║                           085730123218                          ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║                     ┃ XRAY XMENU FIX ERROR ┃                    ║" 
echo "╚═════════════════════════════════════════════════════════════════╝"  
echo "║ 1. Install Sertificat XRAY                                      ║"
echo "║ 2. Cek Sertifikat                                               ║"
echo "║ 3. Restart Xray                                                 ║"
echo "║ 4. Hapus Sertifikat                                             ║"
echo "║ 5. Fix Error Lainnya                                              ║"
echo "║ 6. Menu Utama                                                   ║"
echo "║ 7. Exit                                                         ║"
echo "╚═════════════════════════════════════════════════════════════════╝" 
read -p "Select From Options [ 1 - 7 ] : " menu
echo -e ""
case $menu in 
1)
cert
;;
2)
cek-cert
;;
3)
restart-xray
;;
4)
delete-cert
;;
5)
fix-error
;;
6)
clear
menu
;;
7)
clear
exit
;;
*)
clear
menu-fix
;;
esac
