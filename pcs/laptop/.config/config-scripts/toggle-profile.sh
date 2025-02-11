#! /bin/bash
asusctl profile -n
x=$(asusctl profile -p | tail -n1)
notify-send "$x"
