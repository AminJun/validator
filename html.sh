#!/bin/bash
header=$(sed "s/'/\\\\'/g; s/\"/\\\\\"/g;" "$1" | tr '\n' " ")
command=`cat << EOF 
curl -i -s -k  -X 'POST' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101 Firefox/55.0' -H 'Content-Type: multipart/form-data; boundary=---------------------------404198263875661055448819939' -H 'Referer: https://validator.w3.org/' -H 'Upgrade-Insecure-Requests: 1' --data-binary $'-----------------------------404198263875661055448819939\x0d\x0aContent-Disposition: form-data; name=\"uploaded_file\"; filename=\" \"\x0d\x0aContent-Type: text/html\x0d\x0a\x0d\x0a ${header} \x0a\x0d\x0a-----------------------------404198263875661055448819939\x0d\x0aContent-Disposition: form-data; name=\"charset\"\x0d\x0a\x0d\x0a(detect automatically)\x0d\x0a-----------------------------404198263875661055448819939\x0d\x0aContent-Disposition: form-data; name=\"doctype\"\x0d\x0a\x0d\x0aInline\x0d\x0a-----------------------------404198263875661055448819939\x0d\x0aContent-Disposition: form-data; name=\"group\"\x0d\x0a\x0d\x0a0\x0d\x0a-----------------------------404198263875661055448819939--\x0d\x0a' 'https://validator.w3.org/check'
EOF`
validated=$(eval $command)
error=$(echo $validated | tr ' ' '\n' | grep "msg_err" | wc -l)
warn=$(echo $validated | tr ' ' '\n' | grep "msg_warn" | wc -l)
name=$(basename "$1" .html)
echo -e "$name\t$error\t$warn"
