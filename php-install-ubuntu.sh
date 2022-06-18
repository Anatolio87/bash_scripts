#!/bin/bash

apt-get -y update && apt-get -y upgrade

sudo apt-get -y purge php7.*
sudo apt-get -y autoclean
sudo apt-get -y autoremove

rm -rf /etc/apt/sources.list.d/*

apt-get -y install software-properties-common
#
echo "deb http://deb.megaplan.ru xenial main" >/etc/apt/sources.list.d/megaplan.list
#
echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >/etc/apt/sources.list.d/ondrej-php.list
echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >>/etc/apt/sources.list.d/ondrej-php.list

wget --quiet -O /etc/apt/sources.list http://deb.megaplan.ru/sources.list/xenial

apt-get update

apt-get -y install php7.4-fpm php7.4-imap php7.4-zip php7.4-imagick php7.4-gd php7.4-xsl php7.4-xmlrpc php7.4-bz2 php7.4-apcu php7.4-bcmath php7.4-curl php7.4-dba php7.4-sqlite3 php7.4-soap php7.4-snmp php7.4-pgsql php7.4-enchant php7.4-pspell php7.4-gmp php7.4-igbinary php7.4-intl php7.4-mbstring php7.4-phpdbg php7.4-tidy php7.4-ldap php7.4-memcache php7.4-memcached php7.4-mailparse

