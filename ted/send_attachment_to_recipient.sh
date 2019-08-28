#!/bin/sh
# Sends the attachment to the original recipient based on the SHA1 value by billy 
# Tested on Threat emulation engine 57.990002817

source /tmp/.CPprofile.sh

if [[ $# -eq 0 ]] ; then
    echo 'No arguments exiting'
    exit 0
fi

# We don't know the extension of the file just the location and the SHA1 hash 
filename=`find /var/log/mal_files/$1* 2>/dev/null` 
echo $filename

if [[ ! -f $filename ]] ; then
    echo 'File with SHA1' $1' doesnt exist in /var/log/mal_files'
    exit
fi

# ted files contain md5
attachmentmd5=`md5sum $filename | cut -f 1 -d " "`
echo "Attachment MD5 is: " $attachmentmd5

# In case of multiple ted.elg we need to locate the correct one, hopefully only one occurence 
tedfile=`grep -l $attachmentmd5 $FWDIR/log/ted.elg*`

# Five lines before the md5 is your event id 
eventid=`grep -h -B 5 $attachmentmd5 $tedfile | grep -m1 event_id | sed s/\\:event_id[[:space:]]// | sed -r 's/.{3}$//' | sed -r 's/.{4}//'`
echo "EventID is: " $eventid

# On the first occurence of event id we have the path and 8 lines before it our data 
# from and to keep just the email 
# subject remove parenthesis and quotes 
from=`grep -h $eventid -B 8 $tedfile | grep "\:from" | grep -EiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'`
to=`grep -h $eventid -B 8 $tedfile | grep "\:to" | grep -EiEio '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'`
subject=`grep -h $eventid -B 8 $tedfile | grep "\:subject" | awk -F "[()]" '{ for (i=2; i<NF; i+=2) print $i }' | sed 's/\"//g' `

echo "From    : " $from
echo "To      : " $to
echo "Subject : " $subject
boundary="ZZ_/afg6432dfgkl.94531q"
body="Body of email"
attachments=$filename

# Build headers
# printf '%s\n' "From: $from
# To: $to
printf '%s\n' "Subject: $subject
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=\"$boundary\"

--${boundary}
Content-Type: text/plain; charset=\"US-ASCII\"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

$body
" > /tmp/koko

mimetype=`file -i $filename | awk '{print $2}'` printf '%s\n' "--${boundary}
Content-Type: $mimetype
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=\"$filename\"
" >> /tmp/koko

  base64 "$filename" >>/tmp/koko
  echo >> /tmp/koko

# print last boundary with closing --
printf '%s\n' "--${boundary}--" >>/tmp/koko


read -p "Are you sure you want to send it ? " -n 1 -r 
echo 
if [[ $REPLY =~ ^[Yy]$ ]] then
  # Use the local sendmail to send it to your host
  sendmail --host=1.2.3.4 --from=$from $to < /tmp/koko
  echo "Send"
  rm /tmp/koko
fi