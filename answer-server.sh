#!/bin/bash

#Можно в этот же скрипт засунуть проверку сертификата на валидность https://www.ssllabs.com/ssltest/analyze.html
echo "Введите только название домена без протокола и пробелов:"
echo "Например: yandex.ru"
read name
#Убрать из текста все, что не буквы или цифры и не точка
validchars="$(echo $name | sed -e 's/[^[:alnum:]\.\/]//g')"

if [ $validchars != $name ]
then
{
echo "Вы неправильно ввели домен"
exit 1
}
fi

status="не определен"
status=`curl -s -o /dev/null -w "%{http_code}" https://$name`
echo "https://$name Статус:  $status"

status=`curl -s -o /dev/null -w "%{http_code}" http://$name`
echo "http://$name Статус:  $status"

status=`curl -s -o /dev/null -w "%{http_code}" https://www.$name`
echo "https://www.$name Статус:  $status"

status=`curl -s -o /dev/null -w "%{http_code}" http://www.$name`
echo "http://www.$name Статус:  $status"
