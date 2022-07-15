#!/bin/sh

DIALOG=${DIALOG=dialog}
tempfile= `tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $temfile" 0 1 2 5 15
$DIALOG --title "Ввод данных" --clear \
	--inputbox "Привет, меня зовут bash, а тебя?\n Введите свое имя:" 16 51 2> $tempfile
retval=$?
case $retval in
	0) echo "Очень приятно `cat $tempfile` будем знакомы" ;;
	1) echo "Да ты бука..." ;; 
	255) if test -s $tempfile ; then
		cat $tempfile
	else
		echo "By!"
	fi ;;
esac
