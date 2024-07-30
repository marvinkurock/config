#! /bin/bash
#

monitor_id=$(xrandr | grep " connected" | grep "Display\|HDMI" | awk '{ print $1 }')
if [[ ! -z "$monitor_id" ]]; then
  echo "external screen detected $monitor_id"
  xrandr --output $monitor_id --mode 1920x1080
else
  echo "external monitor not connected"
fi
