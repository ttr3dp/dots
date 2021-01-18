#!/bin/sh
setxkbmap -layout us,rs -variant altgr-intl,latin -option caps:escape -option altwin:swap_alt_win -option grp:shifts_toggle

dunst &
compton &
setbg &
unclutter &
xrdb "$XDG_CONFIG_HOME/X11/xresources"

while :
do
    ssh-agent dwm
done
