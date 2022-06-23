#!/bin/bash

dpkg -l | grep -E \"^i[iU]\\s+unoconv\\s\" 2>&1 
dpkg -l | grep -E \"^i[iU]\\s+megaplan-nodemail\\s\" 2>&1 
nginx -v 2>&1 
service nginx status 2>&1 
/usr/sbin/megaplan-php-manager -p 2>&1 
php -v 2>&1 
service php-fpm status 2>&1 
service php-fpm status 2>&1 
memcached -h | head -n 1 2>&1 
service memcached status 2>&1 
service memcached status 2>&1 
pg_lsclusters | grep ' 9999 ' | cut -f 1 -d ' ' 2>&1 
service postgresql status 2>&1 
postconf mail_version 2>&1 
service postfix status 2>&1 
service erpher status 2>&1 
service erpher status 2>&1 
monit -V | head -n 1 2>&1 
service monit status 2>&1 
redis-server --version 2>&1 
service redis-server status 2>&1 
dpkg -s unoconv | grep '^\\s*Version:' | sed 's/Version: *//' 2>&1 
service unoconv status 2>&1 
dpkg -s megaplan-nodemail | grep '^\\s*Version:' | sed 's/Version: *//' 2>&1 
service megaplan-nodemail status 2>&1 
service megaplan-nodemail status 2>&1 

