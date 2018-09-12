#! /usr/bin/bash

while read -r line; do
    DISP=$(echo $line | awk '{print $11}')
    if [[ -z "$DISP" ]]; then
        continue
    fi

    export DISPLAY=$DISP
    i3lock -c 000000 -s -r 204ab5
done <<< $(w | grep $(whoami))

xset dpms force off

ln -sf Documents/wallpapers/Wall_$(( ( RANDOM % 2 )  + 1 )).png .wallpaper
feh --bg-scale ~/.wallpaper
