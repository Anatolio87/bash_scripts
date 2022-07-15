#!/bin/sh
#
output="psw.txt"
#удалить psw.txt если не нужен
trap "rm -f psw.txt" 0 1 2 5 15

dialog --title "Изменение пароля" \
--insecure \
--clear \
--passwordbox "Введите новый пароль" 10 30 2> $output
reply=$?
case $reply in
0) echo "Вы успешно изменили пароль";;
1) echo "Отмена ввода";;
255) echo "Отмена ввода";;
esac

# getting the value into a variable
var=$(cat $output)
# remove the password file
rm psw.txt
echo "Ваш новый пароль: $var" 
