#!/bin/bash

killall -q polybar

polybar example 2>&1 | tee /tmp/polybar.log & disown

echo "Polybar launched"
