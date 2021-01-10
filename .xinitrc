#!/bin/sh
setxkbmap -layout us,rs -variant altgr-intl,latin -option caps:escape -option altwin:swap_alt_win -option grp:shifts_toggle
xset r rate 200 30

sxhkd &
dunst &
compton &
setbg &
unclutter &
xrdb "$XDG_CONFIG_HOME/X11/xresources"

ssh-agent dwm
