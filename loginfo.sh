#!/bin/bash
cat /var/log/nginx/error.log | grep -E -A8 -e "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}" | grep -A8 -iE "err|crit|warn" | tail -n 12

