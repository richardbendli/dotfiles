#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# rofi wifi menu
#$HOME/.config/rofi/wifimenu/rofi-wifi-menu.sh &


$HOME/.config/polybar/launch.sh &
sxhkd -c ~/.config/bspwm/sxhkdrc &
picom --config $HOME/.config/bspwm/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
#conky -c $HOME/.config/bspwm/system-overview &
xsetroot -cursor_name left_ptr &

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

#Some ways to set your wallpaper besides variety or nitrogen
#feh --bg-scale ~/.config/bspwm/wall.png &
#feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
#feh --randomize --bg-fill ~/Pictures/*
#feh --randomize --bg-fill ~/Dropbox/Apps/Desktoppr/*

run xfce4-power-manager &
run variety &
run nm-applet &
numlockx on &
#blueberry-tray &
#run volumeicon &
#run firefox &
#run pcmanfm &

#----------------------------------------- eof -----------------------------------------
