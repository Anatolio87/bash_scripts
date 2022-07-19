#!/bin/sh
#
#output="psw.txt"
#удалить psw.txt если не нужен
#trap "rm -f psw.txt" 0 1 2 5 15

dialog --title "Изменение пароля" \
--insecure \
--clear \
--passwordbox "Введите новый пароль" 10 30 8> test

# getting the value into a variable
#var=$(cat $output)
# remove the password file
echo "Ваш новый пароль: $test" 
