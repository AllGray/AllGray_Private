#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Clear the screen
reset

# Start info
echo "+-----------------------------------------------------------+"
echo "|                   CHOOSE A NEW HOSTNAME                   |"
echo "| If you want to keep chip as your hostname, just type chip |"
echo "|  Be avare that using chip as hostname can cause problems  |"
echo "|   if you have more than 1 chip connected to you network   |"
echo "+-----------------------------------------------------------+"

# Choose a new host name
read -p "Choose your new host name: " hostname_new

# Setup hostname
read -r hostname_old < /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hosts

# Grab a password for MySQL Root
read -s -p "Enter the password that will be used for MySQL Root: " mysqlrootpassword
debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysqlrootpassword"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysqlrootpassword"

# Grab a password for NextCloud Database User Account
read -s -p "Enter the password that will be used for the NextCloud database: " nextclouddbuserpassword

# Install Features
apt-get -y install apache2 stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip php7.0-APC mysql-server php7.0-mysql libxml2-dev php-zip php-dom php-xmlwriter php-xmlreader php-gd php-curl php-mbstring mariadb-server unzip

# If Apt-Get fails to run completely the rest of this isn't going to work...
if [ $? != 0 ]
then
    echo "Make sure to run: sudo apt-get update && sudo apt-get upgrade"
    exit
fi

# A2ENMOD some stuff
a2enmod proxy_fcgi setenvif
a2enconf php7.0-fpm
a2enmod rewrite

# Restart Apache
service apache2 reload

# Grab local IP
# Grab Local IP address
hostname -I > local_ip.txt
read -r local_ip < local_ip.txt

# Configure some stuff
sed -i '1s/^/<<meta http-equiv="refresh" content="0; URL='http://$local_ip/nextcloud'" />> /' /var/www/html/index.html

# Install NextCloud
cd /var/www/
wget https://download.nextcloud.com/server/releases/nextcloud-11.0.3.zip
unzip nextcloud-11.0.3.zip
rm nextcloud-11.0.3.zip
cd /
mkdir CloudDATA
cd
wget https://raw.githubusercontent.com/AllGray/AllGray_Private/master/permissions.sh
chmod +x permissions.sh
./permissions.sh

cat >/etc/apache2/sites-available/nextcloud.conf <<EOL
`Alias /nextcloud "/var/www/nextcloud/"`
` `
`<Directory /var/www/nextcloud/>`
` Options +FollowSymlinks`
` AllowOverride All`
` `
`<IfModule mod_dav.c>`
` Dav off`
`</IfModule>`
` `
`SetEnv HOME /var/www/nextcloud`
`SetEnv HTTP_HOME /var/www/nextcloud`
` `
`</Directory>`
EOL

# Some more Apache stuff
ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/nextcloud.conf
a2enmod headers
a2enmod env
a2enmod dir
a2enmod mime
a2enmod ssl
a2ensite default-ssl
service apache2 reload


# Make Changes to the PHP 
sed -ie 's/^memory_limit =.*$/memory_limit = 256M/g' /etc/php5/apache2/php.ini
sed -ie 's/^upload_max_filesize =.*$/upload_max_filesize = 20M/g' /etc/php5/apache2/php.ini
sed -ie 's/^post_max_size =.*$/post_max_size = 20M/g' /etc/php5/apache2/php.ini
sed -ie 's/^max_execution_time =.*$/max_execution_time = 300/g' /etc/php5/apache2/php.ini


# Restart Apache
systemctl restart apache2

# Create nextcloud DB and grant nextclouduser User permissions to it

# SQL Code
SQLCODE="
create database nextcloud;
create user 'nextclouduser'@'localhost' identified by \"$nextclouddbuserpassword\";
GRANT SELECT,INSERT,UPDATE,DELETE ON nextcloud.* TO 'nextclouduser'@'localhost';
flush privileges;"

# Execute SQL Code
echo $SQLCODE | mysql -u root -p$mysqlrootpassword

# Clear screen
reset

# Finishing up
echo DONE!
