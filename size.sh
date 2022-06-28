#!/bin/bash
echo "Информация по базе данных"
echo "Версия postgresql"
psql -V
echo "Список баз данных"
sudo -u postgres psql -l
echo "Работающий кластер"
pg_lsclusters
#sudo -u postgres psql -c "SHOW SERVER_VERSION"
echo "*****РАЗМЕР БАЗЫ******"
sudo -u postgres psql -c "SELECT pg_size_pretty(pg_database_size('megaplan'))"

echo "Информация по файлам"
echo "*****РАЗМЕР ФАЙЛОВ uploads****"
du -sh /var/www/megaplan/common/var/uploads
echo "*****РАЗМЕР ФАЙЛОВ /mnt/ext_uploads/"
du -hs /mnt/ext_uploads

