#!/bin/bash

whiptail --title "TerminalGAME" --menu --separate-output "Choose:" 20 78 15 \
"Crawl" "role-playing text based game"  \
"Dopewars" "Clean up New York for drugs"  \
"Empire" "War simulation"  \
"Greed" "Eat as much as possible"  \
"Mancala" "Mancala in the Terminal"  \
"Moon-Buggy" "Jump around in your mooncar"  \
"NetHack" "Dungeon exploration game"  \
"Ninvaders" "Space Invaders in the Terminal"  \
"Nsnake" "Snake in the Terminal"  \
"Slash-em" "Variant of NetHack"  \
"Tint" "This Is Not Tetris"  2>games

CHOICE=$(cat games)
case $CHOICE in		
      Crawl) crawl
      ;;
	  Dopewars) dopewars
      ;;
      Empire) empire
      ;;
      Greed) greed
      ;;
      Mancala) mancala
      ;;
      Moon-Buggy) moon-buggy
      ;;
      NetHack) nethack-console
      ;;
      Ninvaders) ninvaders
      ;;
      Nsnake) nsnake
      ;;
      Slash-em) slashem
      ;;
      Tint) tint
      ;;
    esac
