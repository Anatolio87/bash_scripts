#!/bin/bash
# https://blog.programs74.ru/how-to-get-all-cron-tasks-for-all-linux-user/
#https://ru.wikipedia.org/wiki/Anacron
#https://blog.sedicomm.com/2020/04/11/cron-ili-anacron-kak-planirovat-vypolnenie-zadach-s-pomoshhyu-anacron-v-linux/
#проверка активности cron
echo "АКТИВНЫЕ ПРОЦЕССЫ CRON"
pgrep crond
echo "ЗАДАНИЯ CRON ДЛЯ ПОЛЬЗОВАТЕЛЕЙ"
for user in $(cut -f1 -d: /etc/passwd); do echo "CRON ДЛЯ ПОЛЬЗОВАТЕЛЯ $user"; crontab -u $user -l; done
#Чтобы запретить или разрешить добавление крон-задат, нужно прописать юзера в: /etc/cron.d/cron.allow /etc/cron.d/cron.deny
#некоторые кроны лежат тут:
# ls -lah /etc/cron.daily/
# ls -lah /etc/cron.hourly/
# ls -lah /etc/cron.weekly/
# ls -lah /etc/cron.monthly/
# Программы добавляют задание в крон, чаще для автоматического выполнения сюда: /etc/cron.d/
