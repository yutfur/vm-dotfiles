#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#  Launch Polybar
#  -r, --reload ( Reload when the configuration has been modified )
polybar -r primary &
polybar -r secondary &
