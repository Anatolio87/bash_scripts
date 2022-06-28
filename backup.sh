#!/bin/bash

#Резервная копия данных
#До выполнения работ
rsyns -e ‘ssh -p 22’ -Pzavr root@95.165.5.82:/var/www/megaplan/common/var/uploads ./

#На этапе выполнения работ, досинхронизировать данные
#Еще разок
rsyns -e ‘ssh -p 22’ -Pzavr root@95.165.5.82:/var/www/

mkdir /home/toly/backup

#файл админки
sudo cp  /var/www/admin/etc/storage ./backup

#файл мегаплана
sudo cp /var/www/megaplan/common/config/settings.ini ./backup

#дамп баз данных
sudo -u postgres pg_dump -F c -f /tmp/imaplan.dmp imaplan
cp /tmp/imaplan.dmp ./backup
rm -rf /tmp/imaplan.dmp

sudo -u postgres pg_dump -F c -f /tmp/megaplan.dmp megaplan
cp /tmp/megaplan.dmp ./backup/
rm -rf /tmp/megaplan.dmp

rsyns -e ‘ssh -p 22’ -Pzavr root@95.165.5.82:backup ./


