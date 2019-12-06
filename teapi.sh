#!/bin/sh
# Check Point Threat Prevention API implementation in shell
# Based on the work of Martin K
# Updated by Bill N

ARG_1=$2

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
}

upload() {
echo "UPLOAD"
}

download() {
echo "DOWNLOAD"
}

quota() {
echo "QUOTA"
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
