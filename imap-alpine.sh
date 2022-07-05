#/bin/sh
#обновить пакеты
#https://wiki.alpinelinux.org/wiki/ISP_Mail_Server_3.x_HowTo
#https://www.dmosk.ru/instruktions.php?object=mailserver-ubuntu

apk update

#установка пакетов
apk add php-cgi php-mbstring php php-imap php-psql

#установить имя сервера
hostname mail.netbash.ru

#установить пакет для синхронизации времени
apk add chrony

#создать директорию для почтового домена
mkdir -p /var/www/mail.netbash.ru/www/postfixadmin/templates_c
chown www:www /var/www/mail.netbash.ru/www/postfixadmin/templates_c


cat <<-EOF >/var/www/mail.netbash/index.html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>mail.netbash.ru Redirector</title>
</head>
<body>
<ul>
<li><a href="/postfixadmin">PostfixAdmin</a></li>
<li><a href="/roundcube">Roundcube</a></li>
</ul>
</body>
EOF

#скачать архив последней версии postfix
wget https://sourceforge.net/projects/postfixadmin/files/latest/download -O postfixadmin.tar.gz

#Распаковать архив postfix в созданную директорию postfixadmin
tar -C /var/www/mail.netbash.ru/www/postfixadmin -xvf ~/postfixadmin.tar.gz --strip-components 1

#Задать права каталогу
chown -R www:www /var/www/html/postfixadmin

#Создать базу данных postfix
sudo -u postgres psql -c "create database postfix;"

#Создать роль в базе данных
sudo -u postgres psql -c "CREATE ROLE postfix WITH LOGIN  PASSWORD 'password'"

#Добавить привелегии пользователю
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE "postfix" to postfix;"

#Запустить браузер
http://<IP-адрес сервера>/postfixadmin/public/setup.php

#Далее необходимо редактировать файл /var/www/postfixadmin/config.inc.php
#На самом деле этот файл лучше не трогать, так как в новых версиях есть файл config.local.php , который предопределяет конфигурацию
sed -i -e 's/change-this-to-your.domain.tld/netbash.ru/g' /var/www/mail.netbash.ru/www/postfixadmin/config.inc.php

#Загрузить пакет dovecot
apk add dovecot

#Добавить postfix postfix-pgsql postfix-pcre
apk add postfix postfix-pgsql postfix-pcre

#Создать почтовый каталог и задать владельца vmail
mkdir -p /var/mail/domains

#Задать права для данной директории
chown -R vmail:postdrop /var/mail/domains

#Редактируем файл  /etc/postfix/main.cf

#Запускаю сценарий:
#=======================================================================================================
cd /etc/postfix
mkdir sql
PGPW="ChangeMe"

cat - <<EOF >sql/pgsql_virtual_alias_domain_catchall_maps.cf
user=postfix
password = $PGPW
hosts = localhost
dbname = postfix
query = Select goto From alias,alias_domain where alias_domain.alias_domain = '%d' and alias.address = '@' ||  alias_domain.target_domain and alias.active = true and alias_domain.active = '1'
EOF

cat - <<EOF >sql/pgsql_virtual_alias_domain_mailbox_maps.cf
user=postfix
password = $PGPW
hosts = localhost
dbname = postfix
query = Select maildir from mailbox,alias_domain where alias_domain.alias_domain = '%d' and mailbox.username = '%u' || '@' || alias_domain.target_domain and mailbox.active = '1' and alias_domain.active = '1'
EOF

cat - <<EOF >sql/pgsql_virtual_alias_domain_maps.cf
user=postfix
password = $PGPW
hosts = localhost
dbname = postfix
query = select goto from alias,alias_domain where alias_domain.alias_domain='%d' and alias.address = '%u' || '@' || alias_domain.target_domain and alias.active = '1' and alias_domain.active = '1'
EOF

cat - <<EOF >sql/pgsql_virtual_alias_maps.cf
user=postfix
password = $PGPW
hosts = localhost
dbname = postfix
query = Select goto From alias Where address='%s' and active = '1'
EOF

cat - <<EOF >sql/pgsql_virtual_domains_maps.cf
user=postfix
password = $PGPW
hosts = localhost
dbname = postfix
query = Select domain from domain where domain='%s' and active = '1'
EOF

cat - <<EOF >sql/pgsql_virtual_mailbox_maps.cf
user=postfix
password = $PGPW
hosts = localhost
dbname = postfix
query = Select maildir from mailbox where username='%s' and active = '1'
EOF

chown -R postfix:postfix sql
chmod 640 sql/*
#==============================================================================================

#Newaliases перестраивает базу данных для файла почтовых алиасов. После любых изменений в aliases, необходимо запускать команду newaliases без параметров для создания индексированной версии этого файла. Примеры настройки файла /etc/aliases. 
newaliases

#Запустить postfix и добавить в службу автозагрузки
/etc/init.d/postfix start
rc-update add postfix

#Войти в систему, используя учетную запись superadmin, создать домен для локального ящика (например example.com ) и создать почтовый ящик пользователя (например, root).
#С компьютера отправьте тестовое сообщение:

