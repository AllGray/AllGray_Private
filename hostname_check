#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

read -p "Choose your new host name: " hostname_new
read -r hostname_old < /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hosts


# Finishing up
echo "+---------------------------------------------------------------------+"
echo "|                         Congratulation!                             |"
echo "|                      Your install is done.                          |"
echo "|                 Your HOSTNAME is $hostname_new                      |"
echo "|           Head over to http://your.local.ip/owncloud                |"
echo "|          If you don't have Bonjour/Netatalk installed               |"
echo "|        Head over to http://$hostname_new.local/owncloud             |"
echo "|            if you DO have Bonjour/Netatalk installed                |"
echo "|                       To finish your setup                          |"
echo "|                                                                     |"
echo "| Username:     pick whatever you want                                |"
echo "| Password:     pick whatever you want                                |"
echo "| Mount folder: /media/owncloud/                                      |"
echo "|                                                                     |"
echo "|            This installer was brought to you by AllGray!            |"
echo "+---------------------------------------------------------------------+"
