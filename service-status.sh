#!/bin/bash
#
echo "************************NGINX***********************************"
service nginx status 2>&1
echo "************************PHP-FPM***********************************"
/etc/init.d/php-fpm status 2>&1
echo "************************POSTGRESQL***********************************"
/etc/init.d/postgresql status 2>&1
echo "************************ERPHER***********************************"
/etc/init.d/erpher status 2>&1
echo "************************COMET***********************************"
/etc/init.d/comet status 2>&1
echo "************************NODEMAIL***********************************"
/etc/init.d/megaplan-nodemail status 2>&1
echo "************************CONSUMER***********************************"
/etc/init.d/consumer status 2>&1
echo "************************MAILBOX***********************************"
/etc/init.d/mailbox status 2>&1
echo "************************WORKER***********************************"
/etc/init.d/worker status 2>&1
echo "************************MEMCACHED***********************************"
/etc/init.d/memcached status 2>&1
echo "************************POSTFIX***********************************"
/etc/init.d/postfix status 2>&1 
echo "************************REDIS-SERVER***********************************"
/etc/init.d/redis-server status 2>&1
echo "************************MONIT***********************************"
/etc/init.d/monit status 2>&1 
echo "************************THE END***********************************"
