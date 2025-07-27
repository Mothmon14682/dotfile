#!/usr/bin/env bash

# Self-fork if not already forked
if [[ "$1" != "--child" ]]; then
  nohup "$0" --child >/dev/null 2>&1 &
  exit
fi

val_file="$HOME/.config/waybar/scripts/background/val.txt"
path="$HOME/background/"

# Read old pic
read -r old_pic < "$val_file"

# Pick a new pic
pic="$(find "$path" -type f | shuf -n 1)"
while [ "$old_pic" = "$pic" ]; do
    pic="$(find "$path" -type f | shuf -n 1)"
done

# Save it
echo "$pic" > "$val_file"

# Kill existing wallpaper
killall swaybg 2>/dev/null

# Launch swaybg totally detached
setsid swaybg -i "$pic" -m fill >/dev/null 2>&1 < /dev/null &

# Optional: update colors
wal -i "$pic" -n
