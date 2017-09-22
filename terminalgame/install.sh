#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Clear the screen
reset

# Update
apt-get -y update

# Install Dependencies
apt-get install -y jq whiptail

# Install Games
apt-get -y install crawl dopewars empire greed mancala moon-buggy nethack-console ninvaders nsnake slashem tint

wget https://raw.githubusercontent.com/AllGray/AllGray_Private/master/terminalgame/launcher.sh
chmod +x launcher.sh

#Done!
