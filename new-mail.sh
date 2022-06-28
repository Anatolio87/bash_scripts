#!/bin/bash

#Остановить megaplan-nodemail
/etc/init.d/megaplan-nodemail stop;
/etc/ini.d/megaplan-nodemail status;

#Зашорить /etc/init.d/megaplan-nodemail в начале файла
#exit 0;

#Обновить список пакетов
curl http://deb.megaplan.ru/repo.sh | bash

#ВАЖНО! Первым ставим mailbox
apt install -y imaplan-mailbox

#в крайнем случае
apt -f install

#Потом остальное
apt install -y imaplan-*

#Смотрим статус работы сервисов
/etc/init.d/imaplan-mailbox status
/etc/init.d/mailbox status
/etc/init.d/consumer status
/etc/init.d/worker status

#Чтобы сервисы не падали:
touch /root/mailbox.sh
chmod +x /root/mailbox.sh
echo "
#!/bin/bash

stat=$(/etc/init.d/worker status | grep -o stop) ; if [ «$stat» == «stop» ]; then /etc/init.d/worker restart; fi
stat=$(/etc/init.d/consumer status | grep -o stop) ; if [ «$stat» == «stop» ]; then /etc/init.d/consumer restart; fi
stat=$(/etc/init.d/mailbox status | grep -o stop) ; if [ «$stat» == «stop» ]; then /etc/init.d/mailbox restart; fi
" > /root/mailbox.sh

#Добавить задание в cron -u root
* * * * * bash -x /root/mailbox.sh

#Добавить фичи в секцию bums
bums.common.setting_mail_list = 0
bums.common.mail.migrate_from_imaplan = 0


