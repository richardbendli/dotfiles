#!/usr/bin/env bash

winclass="$(xdotool search --class scpad)"

if [ -z "$winclass" ]; then
    kitty --class scpad
else
    if [ ! -f /tmp/scpad ]; then
        touch /tmp/scpad && xdo hide "$winclass"
    else
        rm /tmp/scpad && xdo show "$winclass"
    fi
fi
