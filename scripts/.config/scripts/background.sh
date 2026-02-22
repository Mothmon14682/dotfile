#!/usr/bin/env bash

if [[ "$1" != "--child" ]]; then
  nohup "$0" --child >/dev/null 2>&1 &
  exit
fi

val_file="$HOME/.config/waybar/scripts/background/val.txt"
path="$HOME/background/static"

read -r old_pic < "$val_file"

pic="$(find "$path" -type f | shuf -n 1)"
while [ "$old_pic" = "$pic" ]; do
    pic="$(find "$path" -type f | shuf -n 1)"
done

echo "$pic" > "$val_file"

killall swaybg 2>/dev/null
killall feh 2>/dev/null
killall mpvpaper 2>/dev/null

is_wayland=$(echo $WAYLAND_DISPLAY)
if [[ -z "$is_wayland"  ]]; then
    feh --bg-fill "$pic"
else
    swaybg -i "$pic" -m fill & disown
fi

wal -i "$pic" -n
