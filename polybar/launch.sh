#!/usr/bin/bash

# Terminate all running instances
killall -q polybar

# Launch bar
echo "---" | tee -a /tmp/polybar_bottom.log
polybar bottom >>/tmp/polybar_bottom.log 2>&1 & disown

echo "Bars launched..."
