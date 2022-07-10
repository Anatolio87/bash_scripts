#!/bin/bash
#Запрос получения токена
request_token=$(curl --request POST \
    --url https://megaplan.megaplan.ru/api/v3/auth/access_token \
    --header 'content-type: multipart/form-data;' \
    --form username='a.chichinov@megaplan.ru' \
    --form password='.chichinov52515.' \
    --form grant_type=password) 1>/dev/null

prefix=$1
token=`echo $request_token | cut -d\" -f4`

curl https://megaplan.megaplan.ru/api/v3/$prefix?%7B%22access_token%22:%22$token%22%7D


