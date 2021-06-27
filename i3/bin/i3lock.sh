#!/bin/bash

revert()
{
  xset dpms 0 0 0
}

trap revert HUP INT TERM
xset +dpms dpms 25 25 25
# Take a screenshot
scrFile="/tmp/screen_locked.png"
if [[ -f "$scrFile" ]]; then
  rm "$scrFile"
fi
scrot "$scrFile"

# Pixellate it 10x
# convert "$scrFile" -scale 10% -scale 1000% "$scrFileBlck"
mogrify -scale 10% -scale 1000%  "$scrFile"
# Lock screen displaying this image.
# i3lock -n
i3lock -n -i "$scrFile"
revert
rm "$scrFile"

# Turn the screen off after a delay.
# sleep 60; pgrep i3lock && xset dpms force off
