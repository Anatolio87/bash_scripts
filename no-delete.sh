#!/bin/bash

#Пример начала и конца выполнения команды awk

awk -F" " 'BEGIN {print "START"} {print $0}
{this="это текст для строки"
print $1 this $2
} END {print "THE END"}' logmeg/log/php.log
