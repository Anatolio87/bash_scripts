#!/bin/bash
#http://kb.megoplan.ru/pages/viewpage.action?pageId=3398338 
echo "Для директора"
user=$(sudo -u postgres psql -Atc "select i.child_id from field_value.ii_user_inheritance i, sdf.perm_user u, sdf.perm_user u2 where u.user_id=i.parent_id and i.child_id=u2.user_id and u2.can_login and u.is_group='t' and u.name='directors' limit 1" megaplan 2>/dev/null) && result=$(sudo php /var/www/megaplan/current/all/cli/run_cli.php "cli://localhost/SdfPerm/User/createOneTimeKeyAuthUser.easy?user_id=$user") && host=$(cat /var/www/megaplan/common/config/settings.ini | grep 'http.host *=' | sed 's/[="]//g;s/http.host//;s/ //g') && echo -e "\nhttp://$host/login/?one_time_key=$result\n"

#Если нужен конкретный сотрудник, тогда необходимо запустить следующую часть скрипта:

echo "Список сотрудников"
sudo -u postgres psql -c "select user_id, name from sdf.perm_user" megaplan
id_user = ""
if [ -n $1 ] then;
	id_user = $1
else
	echo -n "Введите id сотрудника мегаплана: "
	read id_user
fi
php /var/www/megaplan/current/all/cli/run_cli.php "cli://megaplan/SdfPerm/User/createOneTimeKeyAuthUser.easy?user_id=$id_user"

#/login/?one_time_key=
