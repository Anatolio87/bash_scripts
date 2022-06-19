#!/bin/bash
cat /home/toly/logmeg/log/nginx/error.log | grep -E -A8 -e "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}" | grep -A8 -iE "error" | tail -n 6

