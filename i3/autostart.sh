#!/bin/sh

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

$HOME/.config/polybar/launch.sh &

#========================================================================================

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

#========================================================================================

#change your keyboard if you need it
#setxkbmap -layout be

#keybLayout=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')
#
#if [ $keybLayout = "be" ]; then
#  run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc-azerty &
#else
#  run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &
#fi

#sxhkd
sxhkd -c $HOME/.config/i3/sxhkd/sxhkdrc &
#========================================================================================

# compositor
killall picom
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config ~/.config/picom/picom.conf --experimental-backends --vsync &

#========================================================================================

#Some ways to set your wallpaper besides variety or nitrogen
#feh --bg-scale ~/.config/bspwm/wall.png &
feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
#feh --randomize --bg-fill ~/Képek/*
#feh --randomize --bg-fill ~/Dropbox/Apps/Desktoppr/*

#========================================================================================

# have a look on this

#dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
#xsetroot -cursor_name left_ptr &

#========================================================================================

/usr/libexec/polkit-gnome-authentication-agent-1 &
#/usr/lib/polkit-kde-authentication-agent-1 &

#========================================================================================

run variety &
run nm-applet &
run xfce4-power-manager &
numlockx on &
#blueberry-tray &
picom --config $HOME/.config/i3/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
#run volumeicon &
#nitrogen --restore &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#clipmenud &
dunst &
#autotiling &
#~/.fehbg &

#========================================================================================
