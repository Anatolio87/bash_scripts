#!/bin/sh
DIALOG=${DIALOG=dialog}
tempfile=`mktemp 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f tempfile" 0 1 2 5 15

$DIALOG --clear --title "Мои любимые исполнители" \
	--menu "Куда бы вы хотели поехать? :" 40 60 4 \
	"КНДР" "1"\
	"Украина" "2"\
	"Нигерия" "3"\
	"Cирия" "4"\
	"Ирак" "5" 2> $tempfile
retval=$?
choice=`cat $tempfile`
case $retval in
	0) echo "Незабудьте маску, ласты и крем для загара в $choice сейчас жарко" ;;
	1) echo "А как же красивый загар?" ;;
	255) echo "Вы нажали esc" ;;
esac
