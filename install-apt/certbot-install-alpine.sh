#!/bin/sh

#https://techjogging.com/create-letsencrypt-certificate-alpine-nginx.html

#install python
apk add python3

#install certbot
apk add certbot

#установка модуля certbot для nginx
apk add certbot-nginx

echo "*************************************************** \n"
echo "Сейчас будет запущен интерактивный режим \n "
echo "	1.Необходимо ввести: \n "
echo "	2.Электронная почта \n "
echo "	3.Подтвердить согласие с правилами использования \n "
echo "	4.Подтвердить разрешение на отправку писем \n "
echo "	5.Выбрать домен сайта для которого нужет сертификат и подтвердить \n "
echo "..... \n "

#запуск установщика
certbot --nginx

echo "Сертификат успешно установлен \n "
echo "Добавим в службу автозапуска \n"
rc-service crond start && rc-update add crond
rc-service --list | grep -i crond

