#!/bin/sh
setxkbmap -layout us,rs -variant altgr-intl,latin -option caps:escape -option altwin:swap_alt_win -option grp:shifts_toggle

sudo rfkill unblock wifi &
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &
picom --experimental-backends &
setbg &
unclutter &
slstatus &
xrdb "$XDG_CONFIG_HOME/Xresources"

while :
do
	ssh-agent dwm
done
