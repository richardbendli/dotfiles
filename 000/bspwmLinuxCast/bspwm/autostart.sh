#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

[ ! -s ~/.config/mpd/pid ] && mpd &

$HOME/.config/bspwm/polybar/launch.sh &

#change your keyboard if you need it
#setxkbmap -layout be

keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &

~/.config/.fehbg &
xsetroot -cursor_name left_ptr &

picom --config $HOME/.config/picom/picom.conf --vsync --experimental-backends &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &



