#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Clear the screen
reset

# Grab the current hostname
read -r hostname_old < /etc/hostname

# Start info (banner spacing works assuming hostname: chip)
echo "+-----------------------------------------------------------+"
echo "|                   CHOOSE A NEW HOSTNAME                   |"
echo "|                   Your Hostname is $hostname_old                   |"
echo "| If you want to keep $hostname_old as  your hostname just type $hostname_old |"
echo "|  Be avare that using chip as hostname can cause problems  |"
echo "|   if you have more than 1 CHIP connected to you network   |"
echo "+-----------------------------------------------------------+"

# Choose a new host name
read -p "Choose your new host name: " hostname_new

# Setup host name
read -r hostname_old < /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hostname
sed -i "s/$hostname_old/$hostname_new/g" /etc/hosts
hostname $hostname_new

# Install Dependecies
apt-get -y update && apt-get -y install gcc libpam0g-dev unzip

# Get all the files
wget https://dl.gogs.io/0.11.4/raspi2_armv6.zip gogs_for_chip.zip

# Unzip it
unzip gogs_for_chip.zip

# Install it
cd gogs
./gogs web
