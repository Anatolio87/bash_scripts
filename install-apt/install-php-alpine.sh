#!/bin/sh

rm -rf /etc/php8 ;
apk add php8-fpm php8-soap php8-session php8-pgsql php8-openssl php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip php8-apcu php8-pdo_pgsql php8-bcmath php8-gd php8-odbc php8-gettext php8-xmlreader php8-bz2 php8-iconv php8-pdo_dblib php8-curl php8-ctype ;

echo "
PHP_FPM_USER="www"
PHP_FPM_GROUP="www"
PHP_FPM_LISTEN_MODE="0660"
PHP_MEMORY_LIMIT="512M"
PHP_MAX_UPLOAD="50M"
PHP_MAX_FILE_UPLOAD="200"
PHP_MAX_POST="100M"
PHP_DISPLAY_ERRORS="On"
PHP_DISPLAY_STARTUP_ERRORS="On"
PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
PHP_CGI_FIX_PATHINFO=0
" > /etc/profile.d/php8.sh ;

sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = www|g" /etc/php8/php-fpm.d/www.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = www|g" /etc/php8/php-fpm.d/www.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660|g" /etc/php8/php-fpm.d/www.conf
sed -i "s|user\s*=\s*nobody|user = www|g" /etc/php8/php-fpm.d/www.conf
sed -i "s|group\s*=\s*nobody|group = www|g" /etc/php8/php-fpm.d/www.conf
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php8/php-fpm.d/www.conf #uncommenting line

sed -i "s|display_errors\s*=\s*Off|display_errors = On|i" /etc/php8/php.ini
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = On|i" /etc/php8/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php8/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = 200|i" /etc/php8/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = 200|i" /etc/php8/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = 200M|i" /etc/php8/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php8/php.ini
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR|i" /etc/php8/php.ini



