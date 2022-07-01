#!/bin/bash

#Профилактика базы данных
#select count (*) from sdf.notify_notification where is_active = 'f';
#vacuum FULL ANALYZE ;

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
#Полная очистка
echo "Подождите VACUUM FULL ANALYZE....."
sudo -u postgres psql -c "VACUUM FULL ANALYZE"
#реиндексация
echo "Подождите делается REINDEX...."
sudo -u postgres psql -c "REINDEX DATABASE megaplan"


#SELECT nspname || '.' || relname AS "relation",
#    pg_size_pretty(pg_relation_size(C.oid)) AS "size"
#  FROM pg_class C
#  LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
#  WHERE nspname NOT IN ('pg_catalog', 'information_schema')
#  ORDER BY pg_relation_size(C.oid) DESC
#  LIMIT 20;
