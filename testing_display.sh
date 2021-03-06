#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Grab the current hostname
read -r hostname_old < /etc/hostname

# Display the dialog box
dialog --clear --backtitle "Hostname Changer" --title "Change Your HOSTNAME" --inputbox "Choose your new HOSTNAME:" 15 40 4>hostname_new

# Setup Hostname
read -r hostname_new < hostname_new
read -r hostname_old < /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hosts

# Create Readme.txt in /user/chip
cat >/user/chip/hostname_changer.txt <<EOL
"+------------------------------------------------------+"
"|                   Congratulation!!                   |"
"|                 Your install is done                 |"
"|              Your new HOSTNAME is $hostname_new      |"
"|                                                      |"
"|                                                      |"
"|    This installer was brought to you by AllGray!!    |"
"|              And the CHIPinstaller team              |"
"+------------------------------------------------------+"
EOL

dialog --textbox /user/chip/hostname_changer.txt 22 70

# Finishing u
echo "+---------------------------------------------------------------------+"
echo "|                         Congratulation!                             |"
echo "|                      Your install is done.                          |"
echo "|                 Your HOSTNAME is $hostname_new                      |"
echo "|            This installer was brought to you by AllGray!            |"
echo "+---------------------------------------------------------------------+"
