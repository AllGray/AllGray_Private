#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Clear the screen
reset

# First step is to clone my github respository to get all the required files:
apt update && apt install git -y && cd /opt/ && git clone https://github.com/KoljaWindeler/CHIP_TZATZIFFY.git

# The fully equipped Tzatziffy II carries a EEPROM to fulfill the NTC requirement of auto configuration. All you need is to add this dtbo file to your chip:
/opt/CHIP_TZATZIFFY/overlay/chip/install.sh

# CHIP would now be able to turn the screen on (after a reboot) but will still show you a strange screen if you use a screen with a resolution of 800×480, you can fix it by downloading my xorg.conf with this command:
cp /etc/X11/xorg.conf /etc/X11/xorg.conf.bak; cp /opt/CHIP_TZATZIFFY/scripts/xorg.conf /etc/X11/

