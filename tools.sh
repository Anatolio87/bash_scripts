#!/bin/bash

apt update -y
apt upgrade -y

#функция принимает название пакета и если он не установлен, тогда устанавливает
function apt-install()
{
	I= dpkg -s $1 | grep "Status"
	if [ -n "$I" ]
	then :
	else
		apt install -y $1
	fi
}

apt-install vim
apt-install nmap
apt-install telegram-desktop
apt-install openssh-server
apt-install yandex-browser-stable
apt-install gnome-tweaks
apt-install openvpn-server
apt-install tmux
apt-install yandex-disk
apt-install virtualbox
apt-install net-tools
apt-install lftp
apt-install curlftpfs
apt-install git
apt-install curl
apt-install openvpn
apt-install traceroute
apt-install wireshark
apt-install auditd
git clone https://github.com/sullo/nikto.git ~
#конфигурация ssh
#конфигурация vim
#конфигурация командной строки
#настройка внешнего вида
#запустить необходимые вкладки в яндекс браузере
#настройка openvpn-server
#конфигурация yandex-disk 
#добавить инструменты на панель в избранное
yandex-disk setup


apt update -y
apt upgrade -y

#перезагрузка
reboot
