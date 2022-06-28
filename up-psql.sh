#!/bin/bash

#Порт должен быть 9999

#Порядок такой:
#* делаешь дамп кластера PSQL 10
#* Останавливаешь PSQL 10
#* Ставишь PSQL 12
#* проверяешь, что 12-й работает, а 10-й нет.
#* Переустанавливаешь megaplan-fake (это должно перенастроить PSQL 12).
#* Проверяешь, что PSQL 12 на порту 9999.
#* Если нет — нужно руками перенести часть конфигурации из PSQL 10.
#* Восстанавливаешь дамп кластера PSQL 10 на СУБД PSQL 12.

#* Блокировка работающего мегаплан
touch /var/www/megaplan/common/var/tmp/megaplan.lock
#* дамп кластера PSQL 10
sudo -u postgres pg_dumpall > /tmp/cluster.sql
#* Останавливаешь PSQL 10
/etc/init.d/postgresql stop
pg_lsclusters
#* Зашорить PSQL 10
mv /etc/postgresql/10 /etc/postgresql/10_old
#* Ставим PSQL 12 и обновляем megaplan-fake и megaplan-admin, которые возможно подтянут за собой новую базу psql 12
apt install --reinstall megaplan-fake megaplan-admin -y
apt install postgresq postgresql-client-12 -y
#* Переустанавливаешь megaplan-fake (это должно перенастроить PSQL 12).
apt install --reinstall megaplan-fake megaplan-admin -y
#* проверяешь, что 12-й работает, а 10-й нет.
pg_lsclusters
#* Проверяешь, что PSQL 12 на порту 9999.
pg_lsclusters
#* Если нет — нужно руками перенести часть конфигурации из PSQL 10.
cat /etc/postgresql/10/main/pg_hba.conf | tee /etc/postgresql/12/main/pg_hba.conf
echo "
#megaplan-fake#
port = 9999
listen_addresses = 'localhost'
max_connections = 300
max_prepared_transactions = 150
commit_delay = 200
cpu_tuple_cost = 0.001
cpu_index_tuple_cost = 0.0005
cpu_operator_cost = 0.00025
track_activities = off
update_process_title = off
autovacuum = off
ssl = false
lc_messages = 'en_US.UTF-8'
lc_monetary = 'ru_RU.UTF-8'
lc_numeric = 'ru_RU.UTF-8'
lc_time = 'ru_RU.UTF-8'
plpgsql.variable_conflict = use_variable
synchronous_commit = off
include_if_exists = 'local.conf'
#/megaplan-fake#
" >> /etc/postgresql/12/main/postgresql.conf
#* Перезапускаем postgresql
/etc/init.d/postgresql restart
pg_lsclusters
#* Восстанавливаешь дамп кластера PSQL 10 на СУБД PSQL 12.
sudo -u postgres psql -f /tmp/cluster.sql postgres
#* Перезапускаем postgresql
/etc/init.d/postgresql restart
/etc/init.d/postgresql status
pg_lsclusters
#Восстанавливаем доступ в мегаплан
rm -rf /var/www/megaplan/common/var/tmp/megaplan.lock

#Перед тем как сносить старый кластер, необходимо вернуть прежнее имя кластеру и безопасно удалить кластер, чтобы тот не потянул за собой мегаплан
#mv /etc/postgresql/10_old /etc/postgresql/10
#dpkg --purge postgresql-10  postgresql-client-10

