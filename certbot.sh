#!/bin/bash

rm -f /etc/apt/sources.list.d/stunnel4.list

sudo apt-get -y purge certbot
sudo apt-get -y autoremove certbot
sudo apt-get -y autoclean

apt-get install -y apt-transport-https software-properties-common
apt-get -y install software-properties-common
add-apt-repository -y universe
add-apt-repository -y ppa:certbot/certbot
snap install core
snap refresh core
apt -y update

snap install --classic certbot

echo "Первый способ"
echo "Запустите эту команду и пусть Certbot автоматически отредактирует nginx:"
echo "sudo certbot --nginx"
echo "Второй способ"
echo "Внести изменения в конфигурацию nginx вручную, выполните эту команду:"
echo "sudo certbot certonly --nginx"

