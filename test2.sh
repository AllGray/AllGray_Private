#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir /home/chip/temp/

# Display the dialog box
dialog --inputbox "wait 5 seconds and then type TEST" 8 40 2 ; sleep 10>/home/chip/temp/testing

# Finishing u
echo "Check in /home/chip/temp/ to see if the testfile was created"
