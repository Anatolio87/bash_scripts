#!/bin/bash

echo "*****РАЗМЕР БАЗЫ******"
sudo -u postgres psql -c "SELECT pg_size_pretty(pg_database_size('megaplan'))"
echo "*****РАЗМЕР ФАЙЛОВ uploads****"
du -sh /var/www/megaplan/common/var/uploads
echo "*****РАЗМЕР ФАЙЛОВ /mnt/ext_uploads/"
du -hs /mnt/ext_uploads
