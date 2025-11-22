#! /bin/bash
xrandr --output Virtual-1 --auto
sleep 1
killall spice-vdagent -q
spice-vdagent
