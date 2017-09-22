#!/bin/bash

whiptail --title "TerminalGAME" --menu --separate-output "Choose:" 20 78 15 \
"$P1" "Crawl"  \
"$P2" "Dopewars"  \
"$P3" "Empire"  \
"$P4" "Greed"  \
"$P5" "Mancala"  \
"$P6" "Moon Buggy"  \
"$P7" "NetHack Console"  \
"$P8" "Ninvaders"  \
"$P9" "Nsnake"  \
"$P10" "Slash 'em"  \
"$P11" "Tint"  2>games

CHOICE=$(cat games)
case $CHOICE in		
      P1) crawl
      ;;
      P2) dopewars
      ;;
      P3) empire
      ;;
      P4) greed
      ;;
      P5) mancala
      ;;
      P6) moon-buggy
      ;;
      P7) nethack-console
      ;;
      P8) ninvaders
      ;;
      P9) nsnake
      ;;
      P10) slashem
      ;;
      P11) tint
      ;;
    esac
done < games
