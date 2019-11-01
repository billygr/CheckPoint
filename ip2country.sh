#!/bin/bash
# Search for an IP in the IpToCountry.csv file and output the country
# by billy
#

ip2dec () {
    local a b c d ip=$@
    IFS=. read -r a b c d <<< "$ip"
    printf '%d\n' "$((a * 256 ** 3 + b * 256 ** 2 + c * 256 + d))"
    IPDEC=`printf '%d\n' "$((a * 256 ** 3 + b * 256 ** 2 + c * 256 + d))"`
}

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

echo -n "IP in decimal: "
ip2dec "$@"

# Clean up the file from quotes, comments and download time
# There is an old copy at $FWDIR/conf/IpToCountry.csv if in.geod is not running
awk -F, '{ for(i=1;i<=NF;i++) gsub(/^"|"$/,"",$i) gsub(/\#/,"",$i) }1' OFS=','  $FWDIR/tmp/geo_location_tmp/IpToCountry.csv > IpToCountry.csv
sed -i '/Download/d' IpToCountry.csv
sed -i '/^[[:space:]]*$/d' IpToCountry.csv

file="IpToCountry.csv"
i=0
while IFS=, read -r F1 F2 F3 F4
do
  if (( $F1 <= $IPDEC )); then
#   echo $F1
   temp[$i]=$F1
   let i++
  fi
done <"$file"

# Array temp contains all the lines less than or equal to the IP
# the last line of the array contains the range of IPs where your search matches
range=`echo ${temp[${#temp[@]}-1]}`

grep $range IpToCountry.csv
