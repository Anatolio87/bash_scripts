#!/bin/bash
#https://www.dmosk.ru/faq.php?object=linux-pc-info#memoryinfo
#Информация о системе, железо и ресурсы

echo "СИСТЕМА:"
uname -a

echo "ПРОЦЕССОР"
lscpu | grep -i core

echo "ОПЕРАТИВНАЯ ПАМЯТЬ И ПОДКАЧКА"
free -m

echo "ПОКАЗАТЬ НАЛИЧИЕ ИНСТРУКЦИЙ FMA AVX"
grep -e fma -e avx /proc/cpuinfo

echo -n "ПОКАЗАТЕЛЬ ЭНТРОПИИ: "
cat /proc/sys/kernel/random/entropy_avail

echo "ПОКАЗАТЬ ВРЕМЯ РАБОТЫ СИСТЕМЫ"
uptime -p
echo "ДАТА И ВРЕМЯ С МОМЕНТА ЗАГРУЗКИ СИСТЕМЫ"
uptime -s

echo "ПОКАЗАТЬ НАЛИЧИЕ ИНСТРУКЦИЙ FMA AVX"
grep -e fma -e avx /proc/cpuinfo

echo "СПИСОК ДИСКОВ И РАЗМЕР"
lsblk



