#!/bin/bash

killall -q polybar

polybar --config=~/.config/polybar/config.ini example 2>&1 | tee /tmp/polybar.log & disown

echo "Polybar launched"
