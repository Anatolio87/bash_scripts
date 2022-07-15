#! /bin/sh
DIALOG=${DIALOG=dialog}
tempfile=`mktemp 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Не стесняйтесь, выберите любимого певца" \
        --title "Выбор исполнителя" --clear \
        --radiolist "Мой любимый певец, это... " 20 61 5 \
        "Rafi"  "Mohammed Rafi" off \
        "Lata"    "Lata Mangeshkar" ON \
        "Hemant" "Hemant Kumar" off \
        "Dey"    "MannaDey" off \
        "Kishore"    "Kishore Kumar" off \
        "Yesudas"   "K. J. Yesudas" off  2> $tempfile

retval=$?

choice=`cat $tempfile`
case $retval in
  0)
    echo "Ого! Кто бы мог подумать, но выбор пал на '$choice'";;
  1)
    echo "Отказ от ввода.";;
  255)
    echo "Нажата клавиша ESC.";;
esac
