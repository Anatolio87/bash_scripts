#!/bin/bash

#log nginx
#cat /home/toly/logmeg/log/nginx/error.log | grep -n -A8 -E "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}" | grep -A8 -iE "error" | tail -n 6

#cat /home/toly/logmeg/log/nginx/error.log | grep -n -E "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}.*\[error\]" | sed 's/$/\n**********************/g' | tee ~/test.txt | uniq -u -f 50
cat /home/toly/logmeg/log/nginx/error.log | grep -n -E "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}.*\[error\]" | \
tail -n 20 | cut -c -250 | uniq  -f 5 | \
sed 's/$/\n****************************************************************************************************************************/g'

#log erpher
#cat /home/toly/logmeg/log/megaplan/admin-exec.log | grep -A8 -E "^\[[0-9]{2}\.[0-9]{2}\.[0-9]{4}\ [0-9]{1,2}:" | grep -A8 -iE "error" 

