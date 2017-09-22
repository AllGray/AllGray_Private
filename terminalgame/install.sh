#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Clear the screen
reset

apt-get update
apt-get install angband bsdgames crawl dopewars empire greed mancala moon-buggy nethack-console ninvaders nsnake pacman4console ski slashem tint tome

wget https://raw.githubusercontent.com/AllGray/NAME/master/launcher.sh
chmod +x launcher.sh

#Done!
