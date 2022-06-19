#!/bin/bash

status="не определен"
status=`curl -s -o /dev/null -w "%{http_code}" https://$1`
echo "https://$1 Статус:  $status"

status=`curl -s -o /dev/null -w "%{http_code}" http://$1`
echo "http://$1 Статус:  $status"

status=`curl -s -o /dev/null -w "%{http_code}" https://www.$1`
echo "https://www.$1 Статус:  $status"

status=`curl -s -o /dev/null -w "%{http_code}" http://www.$1`
echo "http://www.$1 Статус:  $status"
