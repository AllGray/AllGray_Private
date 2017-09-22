#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

whiptail --msgbox "CHIPinstaller ready, select with spacebar" 8 78

whiptail --title "CHIPinstaller" --checklist --separate-output "Choose:" 20 78 15 \
"$P1" "" off \
"$P2" "" off \
"$P3" "" off \
"$P4" "" off \
"$P5" "" off \
"$P6" "" off \
"$P7" "" off \
"$P8" "" off \
"$P9" "" off \
"$P10" "" off \
"$P11" "" off \
"$P12" "" off \
"$P13" "" off \
"$P14" "" off \
"$P15" "" off \
"$P16" "" off 2>results

while read choice
  do
    case $choice in		
      $P1) angband
      ;;
      $P2) bsdgames
      ;;
      $P3) crawl
      ;;
      $P4) dopewars
      ;;
      $P5) empire
      ;;
      $P6) greed
      ;;
      $P7) mancala
      ;;
      $P8) moon-buggy
      ;;
      $P9) nethack-console
      ;;
      $P10) ninvaders
      ;;
      $P11) nsnake
      ;;
      $P12) pacman4console
      ;;
      $P13) ski
      ;;
      $P14) slashem
      ;;
      $P15) tint
      ;;
      $P16) tome
    esac
done < results
