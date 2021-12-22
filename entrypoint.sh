#!/bin/bash

composer create-project laravel/laravel laravelapp --prefer-dist 
cd laravelapp 
php artisan 
chown -R www-data:www-data /var/www/html/laravelapp
chmod -R 777 /var/www/html/laravelapp/storage /var/www/html/laravelapp/bootstrap/cache
exec "$@"
