# comp344-assign01

### Download Composer
Run this in your terminal to get the latest Composer version: 

`curl -sS https://getcomposer.org/installer | php`

Or if you don't have curl: 

`php -r "readfile('https://getcomposer.org/installer');" | php`

### Install dependencies
`php composer.phar install`

### Creating database
1. Create a database.
2. Run the docs/untitled.sql
3. Configure the database in public/index.php

### Running server
Start your server within public folder using:

`php -S localhost:8080`

or configure a virtualhost and points the root folder to it.