#!/usr/bin/env bash
# 
# Share an area of the screen
# Tested on Ubuntu 19.10
#
# Reqs:
#  gnome-screenshot
#  ffsend
#  notify-send
#  zenity
#
# https://github.com/phar1no/screepl
#

screen_dir=~/Pictures/
date_name=$(date +"%Y-%m-%d_%H:%M:%S")
file_name=${screen_dir}Screeshot_${date_name}.png

gnome-screenshot -af ${file_name}

#DEBUG
#echo "$?"
#echo `ls -l ${file_name}`

if [ $? == 0 ] && [ -e ${file_name} ];then
	notify-send 'Screenshot saved to' $file_name
	short_link=$(ffsend upload -Syc $file_name 2> /dev/null) 
	notify-send 'Screenshot uploaded to' $short_link 
	exit 0

else
	#notify-send 'Screenshot' 'Error'
	zenity --warning --text "Screenshot Error"
	exit 1
fi
