#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar if you are on ArcoLinuxD
# awesome-terminal-fonts
# Tip : There are other interesting fonts that provide icons like nerd-fonts-complete
# --log=error
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# launch bar
polybar top &

if [[ $(xrandr -q | grep 'HDMI-A-0 connected') ]]; then
  polybar top_external &
fi


# desktop=$(echo $DESKTOP_SESSION)
# count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)


# case $desktop in

#     bspwm|/usr/share/xsessions/bspwm)
#     if type "xrandr" > /dev/null; then
#       for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#         MONITOR=$m polybar --reload otp -c ~/.config/polybar/config.ini &
#       done
#     else
#     polybar --reload top_external -c ~/.config/polybar/config.ini &
#     fi;;

#----------------------------------------- second polybar -----------------------------------------

    # second polybar at bottom
    # if type "xrandr" > /dev/null; then
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config.ini &
    #   done
    # else
    # polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config.ini &
    # fi
    # ;;


# esac

#----------------------------------------- eof -----------------------------------------

