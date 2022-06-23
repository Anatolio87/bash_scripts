#!/bin/bash

#cat /home/toly/logmeg/log/nginx/error.log | grep -n -A8 -E "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}" | grep -A8 -iE "error" | tail -n 6
#cat /home/toly/logmeg/log/nginx/error.log | grep -n -E "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}.*\[error\]" | sed 's/$/\n**********************/g' | tee ~/test.txt | uniq -u -f 50
#cat /home/toly/logmeg/log/megaplan/admin-exec.log | grep -A8 -E "^\[[0-9]{2}\.[0-9]{2}\.[0-9]{4}\ [0-9]{1,2}:" | grep -A8 -iE "error"

#Функция принимает на вход путь к лог файлу и шаблон формирования лога
#1.Достает все строки которые начинаются с заданного шаблона
#2.Вывод только последних 20 строк с error
#3.Вырезать только первые 250 символов
#4.Вывод только уникальных строк без учета первых 5 полей
#5.Номер строки в лог файле

function SedLogs()
{
cat "$2" | grep -n -E "$1" | \
tail -n 149620 | cut -c -250 | uniq  -f "$4" | \
sed "s/^/Строка:/g" | \
sed 's/$/\n****************************************************************************************************************************/g' | \
tee ~/bash_scripts/file-logs/$3
}

#/var/log/nginx
#SedLogs "^[0-9]{4}\/[0-9]{2}\/[0-9]{2}.*\[error\]" "/home/toly/logmeg/nginx/error.log" "nginx_log.error" "5"

#/var/log/comet.err
#SedLogs "^(time=\")?[0-9]{4}.[0-9]{2}.[0-9]{2}.*error" "/home/toly/logmeg/comet.err" "comet_log.error" "2"

#/var/log/comet.log
#SedLogs "^(time=\")?[0-9]{4}.[0-9]{2}.[0-9]{2}.*error" "/home/toly/logmeg/comet.log" "comet_log.log" "4"

#/var/log/php.log
#SedLogs "^\[[0-9]{2}-[a-zA-Z]{2,4}-[0-9]{4}.*error" "/home/toly/logmeg/php.log" "php.log" "4"

#/var/log/pgbouncer/pgbouncer.log
#SedLogs "^[0-9]{4}-[0-9]{2}-[0-9]{2}.*error" "/home/toly/logmeg/pgbouncer/pgbouncer.log" "pgbouncer_log.log" "3"

#/var/log/megaplan/common/var/logs/prod*
#SedLogs "\ 500\ " "$(ls -1 ~/logmeg/megaplan/common/var/logs/prod* | tail -n 1)" "prod_log.log" "1"


