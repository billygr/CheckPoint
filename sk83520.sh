#!/bin/bash
# sk83520 connectivity check
# Initial URL https://community.checkpoint.com/t5/Security-Gateways/sk83520-how-to-check-connectivity-to-CP/m-p/31874/highlight/true#M2558
# Run on the gw/mgmt curl_cli -k  https://raw.githubusercontent.com/billygr/CheckPoint/master/sk83520.sh > sk83520.sh
# chmod +x sk83520.sh
# ./sk83520.sh

source $CPDIR/tmp/.CPprofile.sh

check_url () {
  result=" [ ERROR ]"
  name="$2 "
  while [ ${#name} -lt 74 ]; do name="$name."; done
  echo -en "$name "
  response=$(curl_cli --cacert $CPDIR/conf/ca-bundle.crt -LisI $1 | grep "HTTP/1.1" | awk 'END { print }')
  status=$(echo "${response}" | awk 'END { print $2 " " $3 " " $4}')
  status_code=$(echo ${response} | awk '{ print $2 }')
  if [ "${status_code}" != "200" ]; then
    echo "${result} - Got HTTP ${status_code}"
    else result=" [ OK ]"
    echo "${result}"
  fi
}

check_url_without_head () {
  result=" [ ERROR ]"
  name="$2 "
  while [ ${#name} -lt 74 ]; do name="$name."; done
  echo -en "$name "
  response=$(curl_cli --cacert $CPDIR/conf/ca-bundle.crt --location --include --silent $1 | grep "HTTP/1.1" | awk 'END { print }')
  status=$(echo "${response}" | awk 'END { print $2 " " $3 " " $4}')
  status_code=$(echo ${response} | awk '{ print $2 }')
  if [ "${status_code}" != "200" ]; then
    echo "${result} - Got HTTP ${status_code}"
    else result=" [ OK ]"
    echo "${result}"
  fi
}
echo
echo "sk83520 How to verify that Security Gateway and/or Security Management Server can access Check Point servers"
echo

check_url 'http://cws.checkpoint.com/APPI/SystemStatus/type/short' 'Social Media Widget Detection'
check_url 'http://cws.checkpoint.com/URLF/SystemStatus/type/short' 'URL Filtering Cloud Categorization'
check_url 'http://cws.checkpoint.com/AntiVirus/SystemStatus/type/short' 'Virus Detection'
check_url 'http://cws.checkpoint.com/Malware/SystemStatus/type/short' 'Bot Detection'

check_url 'https://updates.checkpoint.com/' 'IPS Updates'

check_url 'https://crl.godaddy.com/gdroot-g2.crl' 'CRL check godaddy Update Service uses it for revocation'

check_url 'http://crl.globalsign.net/root-r2.crl' 'CRL check globalsign CRL that updates service certificate uses'

check_url 'http://dl3.checkpoint.com/paid/90/902caf44a13d71e91a35315e4a28caa8/CheckPoint_Stencils_for_Visio.zip?HashKey=1480871979_bb9dd6cf9a98c6bf41f3cd1fd147c855&xtn=.zip' 'Download Service Updates'

check_url 'https://usercenter.checkpoint.com/usercenter/services/ProductCoverageService' 'Contract Entitlement'

check_url 'https://usercenter.checkpoint.com/usercenter/services/BladesManagerService' 'Software Blades Manager Service'

check_url_without_head 'http://resolver1.chkp.ctmail.com' 'Suspicious Mail Outbreaks'

check_url_without_head 'http://download.ctmail.com' 'Anti-Spam'

check_url 'https://te.checkpoint.com/tecloud/Ping' 'Threat Emulation'

check_url 'http://teadv.checkpoint.com/' 'Threat Emulation Advanced'
check_url 'https://ptcs.checkpoint.com' 'PTC Updates'
check_url 'https://ptcd.checkpoint.com' 'PTC Updates'

check_url 'http://kav8.zonealarm.com/version.txt' 'Anti-Virus Deep inspection in R77.10 and higher'

check_url 'http://kav8.checkpoint.com/version.txt' 'Traditional Anti-Virus'

check_url 'http://avupdates.checkpoint.com/UrlList.txt' 'Traditional Anti-Virus, Legacy URL Filtering'

check_url 'http://sigcheck.checkpoint.com/Siglist2.txt' 'Download of signature updates for Traditional Anti-Virus, etc'

check_url 'http://secureupdates.checkpoint.com' 'Manage Security Gateways'

check_url 'https://productcoverage.checkpoint.com/ProductCoverageService' 'Makes sure the machines contracts are up-to-date'

check_url 'https://sc1.checkpoint.com/sc/images/checkmark.gif' 'Download of icons and screenshots from Check Point media storage servers'
check_url 'https://sc1.checkpoint.com/za/images/facetime/large_png/60342479_lrg.png' 'Download of icons and screenshots from Check Point media storage servers'
check_url 'https://sc1.checkpoint.com/za/images/facetime/large_png/60096017_lrg.png' 'Download of icons and screenshots from Check Point media storage servers'

check_url_without_head 'https://push.checkpoint.com/push/ping' 'Push Notifications'

check_url 'http://downloads.checkpoint.com' 'Download of Endpoint Compliance Updates'

check_url 'http://productservices.checkpoint.com' 'Entitlement/Licensing Updates'
