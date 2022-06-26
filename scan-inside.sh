#!/bin/bash

#Сие скрипт для сканирования сетевой активности внутри сервера, информация о подключенных пользователяx, использование ресурсов сервера
#http://rus-linux.net/MyLDP/consol/find-recent-file.html
#netstat -ltup где Флаг -l говорит netstat вывести все прослушивающие сокеты, -t означает показать все TCP соединения, -u для показа всех UDP соединений и -p включает показывать PID и имя программы/приложения, которое прослушивает порт. Если вы хотите, чтобы порты были показаны как числа, то добавьте флаг -n.
#Альтернативная утилита ss принимает такие же параметры, но если добавить опцию -p тогда покажет процессы которые используют сокеты
#В параметр state можно передать одно из следующих значений:

#established
#syn-sent
#syn-recv
#fin-wait-1
#fin-wait-2
#time-wait
#closed
#close-wait
#last-ack
#closing
#all  - все состояния
#connected - все кроме прослушиваемых и закрытых
#synchronized - все кроме syn-sent
#bucket -  time-wait и syn-recv
#big - все кроме bucket

echo "SSH СОЕДИНЕНИЯ"
ss -ptu | grep ssh
#Пока непонятная мне альтернативная команда
#ss -at '(dport=:ssh or sport=:ssh)'

echo "ПРОСЛУШИВАЕМЫЕ ПОРТЫ: "
ss -ltupn

echo "УСТАНОВЛЕННЫЕ СОЕДИНЕНИЯ"
ss -t4 state established

echo "ПОРТЫ В СОСТОЯНИИ ОЖИДАНИЯ"
ss -utn  state time-wait

echo "ПРИЛОЖЕНИЯ КОТОРЫЕ ПРОСЛУШИВАЮТ ДАННЫЕ ПОРТЫ"
#Сюда необходимо добавить подстановку портов, которые были найдены выше
#Анализ открытых файлов
#lsof | grep sshd (файлы которые использует служба sshd)
#lsof / | grep sshd (только файл)
#lsof | grep deleted (файл который уже удален, возможно чтобы не быть обнаруженным антивирусом)
#lsof /usr (посмотреть открытые файлы в определенной директории)
lsof -i :443
echo "ФАЙЛЫ КОТОРЫЕ БЫЛИ УДАЛЕНЫ" 
lsof | grep deleted

echo "20 САМЫХ ЗАГРУЖЕННЫХ ПРОЦЕССОВ:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 20
#Обновление самых загруженных процессов:
#watch "ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head"
#Альтернативная команда top
#top -b -n 1 | head -n 20  | tail -n 10

echo "ЗАГРУЖЕННОСТЬ ДИСКОВ:"
iostat -hx

#Анализ открытых файлов
#lsof | grep sshd (файлы которые использует служба sshd)
#lsof / | grep sshd (только файл)
#lsof | grep deleted (файл который уже удален, возможно чтобы не быть обнаруженным антивирусом)
#lsof /usr (посмотреть открытые файлы в определенной директории)

echo "ПОИСК ФАЙЛОВ КОТОРЫЕ БЫЛИ ИЗМЕНЕНЫ МЕНЕЕ ЧЕМ 1 ДЕНЬ НАЗАД"
echo "bin"
find /bin/ -mtime -1
echo "system"
find /etc/systemd/system/ /usr/lib/systemd/system/ -mtime -1
echo "ПОИСК ФАЙЛОВ КОТОРЫЕ БЫЛИ ИЗМЕНЕНЫ МЕНЕЕ 20 ДНЕЙ НАЗАД И БОЛЕЕ ЧЕМ 1 ДЕНЬ НАЗАД"
echo "bin"
find /bin/ -mtime +1 -mtime -20
echo "system"
find /etc/systemd/system/ /usr/lib/systemd/system/ -mtime +1 -mtime -20
echo "ФАЙЛЫ ПРАВА КОТОРЫХ БЫЛ ИЗМЕНЕН МЕНЕЕ 20 ДНЕЙ НАЗАД"
echo "bin"
find /bin/ -ctime -20
echo "system"
find /etc/systemd/system/ /usr/lib/systemd/system/ -ctime -20

echo "ПОКАЗАТЬ АКТИВНЫЕ СЛУЖБЫ"
systemctl list-unit-files

echo "ПОКАЗАТЬ ПОЛЬЗОВАТЕЛЕЙ С ПРАВАМИ SUDO"
cat /etc/sudoers | grep ALL

#echo "ПОКАЗАТЬ К КАКИМ ФАЙЛАМ ОБРАЩАЕТСЯ PHP-FPM"
#lsof -c php-fpm

#echo "ВСЕ ФАЙЛЫ ПОЛЬЗОВАТЕЛЯ:"
#find / -user $user -print

#echo "ВЫВОД АКТИВНЫХ ПРОЦЕССОВ ПОЛЬЗОВАТЕЛЯ:"
#ps -u $user

#БЛОКИРОВКА ПОЛЬЗОВАТЕЛЯ
#sudo passwd -l $user

#найти все файлы пользователя и изменить права на другого пользователя
#find / -user testuser -exec chown toly:toly {} \;

#В Linux имеются скрипты, которые выполняются автоматически при входе пользователя в систему
#/etc/profile
#/etc/profile.d/*
#~/.bash_profile
#~/.bashrc
#/etc/bashrc

#Таймеры systemd для замены Cron
#systemctl list-timers

#Возможная последовательность команд для деактивации вирусов:
#sudo systemctl disable pwnrige.service pwnrigl.service &&
#sudo chattr -ai /bin/sysdr /bin/bprofr /bin/crondr /etc/systemd/system/pwnrige.service /usr/lib/systemd/system/pwnrigl.service /etc/cron.d/root /etc/cron.d/nginx /etc/cron.d/apache /var/spool/cron/root /root/.bash_profile &&
#sudo rm /bin/sysdr /bin/bprofr /bin/crondr /etc/systemd/system/pwnrige.service /usr/lib/systemd/system/pwnrigl.service /etc/cron.d/root /etc/cron.d/nginx /etc/cron.d/apache /var/spool/cron/root /root/.bash_profile &&
#reboot




