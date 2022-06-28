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


#* дамп кластера PSQL 10
sudo -u postgres pg_dumpall > /tmp/cluster.sql
#* Останавливаешь PSQL 10
#* Ставишь PSQL 12
#* проверяешь, что 12-й работает, а 10-й нет.
#* Переустанавливаешь megaplan-fake (это должно перенастроить PSQL 12).
#* Проверяешь, что PSQL 12 на порту 9999.
#* Если нет — нужно руками перенести часть конфигурации из PSQL 10.
#* Восстанавливаешь дамп кластера PSQL 10 на СУБД PSQL 12.



#pg_hba.conf можно просто скопировать.


#В файл /etc/postgresql/12/main/postgresql.conf
#Добавить:
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
"
