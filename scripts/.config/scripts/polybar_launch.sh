#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bar1 and bar2

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

until xrandr --query | grep -q " connected"; do
  sleep 0.2
done

# Give tray + dex time to settle
sleep 1

polybar bar1 &

