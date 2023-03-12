#!/bin/sh
setxkbmap -layout us,rs -variant altgr-intl,latin -option caps:escape -option altwin:swap_alt_win -option grp:shifts_toggle

picom &
setbg &
unclutter &
slstatus &
xrdb "$XDG_CONFIG_HOME/Xresources"

while :
do
	ssh-agent dwm
done
