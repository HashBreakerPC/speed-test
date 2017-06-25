#!/bin/bash
#
#  		wifi-reg.sh
#  
#  Copyright 2017 c.realkiller <dino.tartaro@gmail.com>
#  
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#Displays the signal quality and the connection to adjust the wifi antenna
#for cantenna regulations (prinless tube ;-) )

lname=`basename $0 | cut -d '.' -f 1`
echo ${lname^^}
check_dp(){
	name_d=`uname -n`
	if [[ "$name_d" = "debian" ]] || [[ "$name_d" = "ubuntu" ]] || [[ "$name_d" = "kali" ]]
	then
		dep=`dpkg -s wireless-tools |awk '/status|install/{print $3}'`
		if [[ "$dep" != "ok" ]]
		then
				echo "wireless-tools is not installed"
				sleep 2
				echo "install it whith: sudo apt install wireless-tools"
				sleep 2
				echo "and launch this script again....exit!"
				sleep 3
				exit 1
		fi
		else
				echo "wireless-tools is not installed"
				sleep 2
				echo "install it whith your package manager (apt, yum etc.. wireless-tools)"
				sleep 2
				echo "and launch this script again....exit!"
				sleep 3
				exit 1
	fi
}


check_dp
if [ "$(id -u)" != "0" ]; then
	sudo -k
	wl=`sudo -S iwgetid | cut -d ' ' -f 1`
		if sudo -n true 2>/dev/null; then 
			while (true) 
			do
				clear
				echo ${lname^^}
				echo
				sudo -S iwconfig $wl | grep -o -e '$wl' -o -e 'Link Quality=[^*]*' | cut -d '=' -f1,2,3,4
				echo
				echo "CTRL+C to stop this script"
				sleep 1

			clear
			done
			else
			echo "close script"
			sleep 3
			exit 1
		fi
	else

	wl=`iwgetid | cut -d ' ' -f 1`

	while (true)
	do 
		clear
		echo ${lname^^}
		echo
		sudo -S iwconfig $wl | grep -o -e '$wl' -o -e 'Link Quality=[^*]*' | cut -d '=' -f1,2,3,4
		echo
		echo "CTRL+C to stop this script"
		sleep 1

	clear

	done
fi	
exit 0



