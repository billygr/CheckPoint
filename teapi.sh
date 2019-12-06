#!/bin/sh
# Check Point Threat Prevention API implementation in shell
# Based on the work of Martin K
# Updated by Bill N
# Uses jq from /opt/CPshrd-R80.30/bin/jq

ARG_1=$2

# define API server
# TE cloud API server is located on te.checkpoint.com, 127.0.0.1:18194 is the local one
#TESERVER=te.checkpoint.com
TESERVER=127.0.0.1:18194
TEAPIKEY=""

query() {
  echo "QUERY"
  [[ -z "$ARG_1" ]] && { echo "No file specified exiting" ; exit 1; }
  [ ! -f "$ARG_1" ] && { echo "$ARG_1 is not a file exiting" ; exit 1;}

  # file to investigate
  TEFILE=$ARG_1
  filename=$(basename "$TEFILE")
  extension="${filename##*.}"

  echo "Filename: ${filename}"
  echo "Extension: $extension"

  # calculate hash for $TEFILE
  TESHA1=`sha1sum $TEFILE | cut -f1 -d" "`
  echo "file: ${TEFILE} sha1: ${TESHA1}"

  # build request body
  TEQ=`jq -c -n --arg sha1 "$TESHA1" --arg filename "$filename" --arg extension "$extension"  '{request: [{sha1: $sha1, file_type: $extension, file_name: $filename, features: ["te"], te: {reports: ["pdf","xml", "tar", "full_report"]}} ]}'`

  # display it formated via jq
  echo $TEQ | jq .

  # place API request based on previously constructed body TEQ
  TEQRESP=$(curl_cli -d "$TEQ" -k -s -H "Content-type: application/json" -H "Authorization: $TEAPIKEY" https://$TESERVER/tecloud/api/v1/file/query)

  # display response formated by jq
  echo $TEQRESP | jq .
}

upload() {
  echo "UPLOAD"
  [[ -z "$ARG_1" ]] && { echo "No file specified exiting" ; exit 1; }
  [ ! -f "$ARG_1" ] && { echo "$ARG_1 is not a file exiting" ; exit 1;}

  # file to upload
  TEFILE=$ARG_1
  filename=$(basename "$TEFILE")
  extension="${filename##*.}"

  echo "Filename: ${filename}"
  echo "Extension: $extension"

  # calculate hash for $TEFILE
  TESHA1=`sha1sum $TEFILE | cut -f1 -d" "`
  echo "file: ${TEFILE} sha1: ${TESHA1}"

  # our upload request body will be same as for query
  TEQ=`jq -c -n --arg sha1 "$TESHA1" --arg filename "$filename" --arg extension "$extension"  '{request: [{sha1: $sha1, file_type: $extension, file_name: $filename, features: ["te"], te: {reports: ["pdf","xml", "tar", "full_report"]}} ]}'`
  TEU=$TEQ

  # do multipart request with both API request body and the file
  TEURESP=$(curl_cli -F "request=$TEU" -F "file=@$TEFILE" -k -s -H "Content-Type: multipart/form-data" https://$TESERVER/tecloud/api/v1/file/upload )

  # format response with jq
  echo $TEURESP | jq .
}

download() {
  echo "DOWNLOAD"
}

quota() {
  echo "QUOTA"
  [[ -z "$TEAPIKEY" ]] && { echo "Empty TEAPIKEY, probalby using local TE, exiting" ; exit 1; }

  TEQRESP=$(curl_cli -k -s -H "Content-type: application/json" -H "Authorization: $TEAPIKEY" https://$TESERVER/tecloud/api/v1/file/quota)

  # display response formated by jq
  echo $TEQRESP | jq .
}

display_help() {
    echo "Usage: $0 {query|upload|download|quota}" >&2
    echo
    exit 1
}

case "$1" in
  query)
    query
    ;;
  upload)
    upload
    ;;
  download)
    download
    ;;
  quota)
    quota
    ;;
  *)
    display_help

   exit 1
   ;;
esac
