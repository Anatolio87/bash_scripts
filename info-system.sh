#!/bin/bash
#https://www.dmosk.ru/faq.php?object=linux-pc-info#memoryinfo
#Информация о системе, железо и ресурсы
echo -e "  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"
echo "ДИСТРИБУТИВ И РЕЛИЗ:"
echo "*********************"
lsb_release -d
echo -e "\nПРОЦЕССОР:"
echo "***********"
lscpu | grep -i core
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"

echo "ТИП СЕРВЕРА:"
echo "*****************************"
dmidecode | grep Product
lshw -class system
dmesg | grep "Hypervisor detected" #Если машина физическая, тогда ничего не покажет, либо покажет KVM
hostnamectl #Chassis:
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"

echo "ОПЕРАТИВНАЯ ПАМЯТЬ И ПОДКАЧКА"
echo "*****************************"
free -m
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"

echo "НАЛИЧИЕ ИНСТРУКЦИЙ FMA AVX"
echo "**************************"
if [ $(grep -iwc "fma" /proc/cpuinfo) -gt 0 ]; then echo "FMA есть"; else echo "FMA нет"; fi
if [ $(grep -iwc "avx" /proc/cpuinfo) -gt 0 ]; then echo "AVX есть"; else echo "AVX нет"; fi
if [ $(grep -iwc "avx2" /proc/cpuinfo) -gt 0 ]; then echo "AVX2 есть"; else echo "AVX2 нет"; fi
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"

echo "ПОКАЗАТЕЛЬ ЭНТРОПИИ:"
echo "*********************"
cat /proc/sys/kernel/random/entropy_avail
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"

echo "ВРЕМЯ РАБОТЫ СИСТЕМЫ:"
echo "**********************"
uptime -p
echo -n "дата и время с момента загрузки: "
uptime -s
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"

echo "СПИСОК ДИСКОВ И РАЗМЕР"
echo "***********************"
lsblk | grep -vwE "loop[0-9]{1,3}"
echo -e "\n  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . \n"
