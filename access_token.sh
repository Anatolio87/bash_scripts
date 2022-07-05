#!/bin/bash
#Запрос получения токена
curl --request POST \
    --url https://megaplan.megaplan.ru/api/v3/auth/access_token \
    --header 'content-type: multipart/form-data;' \
    --form username='a.chichinov@megaplan.ru' \
    --form password='12345' \
    --form grant_type=password

#Далее токен доступа необходимо использовать в различных запросах
#Строка браузера: https://megaplan.megaplan.ru/api/v3/offer?{"access_token": "MTJkMjRkYzIzZDc4ZmYwZjY2ZTM2OWIwOTUyY2Y0ZTU5OWQzNzA4MGEwMWMzNWVjNGVkYjgyMjY2ZDFjMDkxYg "}

#Запрос curl: curl https://megaplan.megaplan.ru/api/v3/offer?%7B%22access_token%22:%22YzkzODhiYzEzNTRkNDQ4MjU4NGE2MmZmYTQ2NWUwOTdlMmU5MTY4OWZhMjZhMzZjZTI4YzE3MWVlMGI1ZTJlMQ%22%7D


