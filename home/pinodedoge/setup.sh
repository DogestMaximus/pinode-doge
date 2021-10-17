#!/bin/bash

		#HEIGHT=20
		#WIDTH=60
		#CHOICE_HEIGHT=8
		CHOICE=$(whiptail --backtitle "Welcome" --title "PiNode-DOGE Settings" --menu "\n\nWhat would you like to configure?" 20 60 10 \
	"1)" "Exit to Command line" \
    "2)" "System Settings" \
	"3)" "Update Tools" 2>&1 >/dev/tty)
	
	case $CHOICE in
		
		"1)")
		;;
				
		"2)")CHOICE2=$(whiptail --backtitle "Welcome" --title "PiNode-DOGE Settings" --menu "\n\nSystem Settings" 20 60 10 \
				"1)" "Hardware & WiFi Settings (raspi-config)" \
				"2)" "Master Login Password Set" \
				"3)" "USB storage setup" \
				"4)" "SD Card Health Checker" 2>&1 >/dev/tty)
				
				case $CHOICE2 in
		
					"1)")	whiptail --title "PiNode-DOGE Settings" --msgbox "You will now be taken to the Raspbian menu to configure your hardware" 8 78;
							sudo raspi-config; . /home/pinodedoge/setup.sh
					;;
				
					"2)") 	if (whiptail --title "PiNode-DOGE Set Password" --yesno "This will change your SSH/Web terminal log in password\n\nWould you like to continue?" 12 78); then
					. /home/pinodedoge/setup-password-master.sh
							else
					. /home/pinodedoge/setup.sh
							fi
					;;
					
					"3)")	if (whiptail --title "PiNode-DOGE configure storage" --yesno "This will allow you to add USB storage for the Dogecoin blockchain.\n\nConnect your device now.\n\nWould you like to continue?" 16 78); then
					. /home/pinodedoge/setup-usb-select-device.sh
							else
					. /home/pinodedoge/setup.sh
							fi
					;;
					
					"4)")	if (whiptail --title "PiNode-DOGE MicroSD Health Check" --yesno "This utility (agnostics) will run speed tests on your SD card read/write functions to give an indication of its current health.\n\nBefore starting this check, stop all services that are currently reading/writing (Node and BlockExplorer) for most accurate results.\n\nWould you like to continue?" 16 78); then
					 clear;
					 echo -e "\e[32mChecking for required tools...\e[0m";
					 sudo apt install agnostics -y
					 echo -e "\e[32mSuccess\e[0m";
					 sleep 2;
					 echo -e "\e[32mRunning test script. This will take a few minutes...\e[0m";
					 sudo sh /usr/share/agnostics/sdtest.sh;
					 read -n 1 -s -r -p "Press any key to return to Menu"
							else
					. /home/pinodedoge/setup.sh
							fi
					;;
				esac
				. /home/pinodedoge/setup.sh
				;;
				
		"3)")CHOICE3=$(whiptail --backtitle "Welcome" --title "PiNode-DOGE Settings" --menu "\n\nUpdate Tools" 20 60 10 \
				"1)" "Update Dogecoin" \
				"2)" "Update PiNode-DOGE" \
				"3)" "Update system packages and dependencies" 2>&1 >/dev/tty)
				
				case $CHOICE3 in
		
					"1)")	if (whiptail --title "PiNode-DOGE Update Dogecoin" --yesno "This will run a check to see if a Dogecoin update is available\n\nIf an update is found PiNode-DOGE will perform the update.\n\nWould you like to continue?" 12 78); then
							. /home/pinodedoge/setup-update-dogecoin.sh
							else
							. /home/pinodedoge/setup.sh
							fi
						;;
				
					"2)")	if (whiptail --title "Update PiNode-DOGE" --yesno "This will check for updates to PiNode-DOGE Including performance, features and web interface\n\nWould you like to continue?" 12 78); then
							. /home/pinodedoge/setup-update-pinodedoge.sh
							else
							. /home/pinodedoge/setup.sh
							fi
						;;
								
					"3)")	if (whiptail --title "Update System" --yesno "PiNode-DOGE will perform a check for background system updates of your OS's packages and dependencies.\n\nWould you like to continue?" 12 78); then
							clear; sudo apt-get update && sudo apt-get upgrade -y; sleep 3;
							. /home/pinodedoge/setup.sh
							else
							. /home/pinodedoge/setup.sh
							fi
						;;
				esac
				. /home/pinodedoge/setup.sh
				;;

	esac
clear
echo -e "\e[32mReturn to the settings menu at any time by typing 'setup'\e[0m";
