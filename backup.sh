#!/bin/bash

#Резервная копия данных
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

#На всякий случай можно добавить файл контрольных сумм
md5sum ./backup/* > ./backup/mk5sum.txt

#в этом файле резерв эквивалентный backup
#/var/www/megaplan/common/var/backup/admin/megaplan-r2004…   ..zip


#*****************************************************************************
#Если есть uploads внутри мегаплана
#восстановление из резервной копии
rsyns -e ‘ssh -p 22’ -Pzavr root@95.165.5.82:/var/www/megaplan/common/var/uploads ./

rsyns -e ‘ssh -p 22’ -Pzavr root@95.165.5.82:backup ./

#проверяем контрольные суммы
md5sum -c ./backup/md5sum.txt
#восстанавливаем файл админки
cp ./backup/storage /var/www/admin/etc/storage
chown www-data:www-data /var/www/admin/etc/storage
chmod 644 /var/www/admin/etc/storage

#восстанавливаем файл мегаплана
cp ./backup/settings.ini /var/www/megaplan/common/config/settings.ini
chown www-data:www-data /var/www/megaplan/common/config/settings.ini
chmod 644 /var/www/megaplan/common/config/settings.ini

#базы данных
service postgresql stop
service postgresql start
sudo -u postgres psql -Atc "DROP DATABASE megaplan" postgres
sudo -u postgres psql -Atc "DROP DATABASE imaplan" postgres
#Проверим что базы данных больше нет
sudo -u postgres psql -c "\l" postgres
#Создать роли и базы данных
sudo -u postgres psql -Atc "CREATE ROLE imaplan" postgres
sudo -u postgres psql -Atc "CREATE ROLE megaplan" postgres
sudo -u postgres psql -Atc "CREATE DATABASE imaplan OWNER imaplan" postgres
sudo -u postgres psql -Atc "CREATE DATABASE megaplan OWNER megaplan" postgres

#Теперь у нас есть пустые базы данных и можно импортировать данные
sudo -u postgres pg_restore imaplan -f ./backup/imaplan.dmp -d imaplan
sudo -u postgres pg_restore megaplan -f ./backup/megaplan.dmp -d megaplan

#Если дистрибутив выше версией, может ничего не сработать, тогда потребуется накатить миграции
#sudo -u www-data php /var/www/megaplan/current/app/console s:m:u
