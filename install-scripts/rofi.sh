#!/bin/bash
mkdir -p ~/.local/share/rofi/themes
mkdir -p ~/.config/rofi/
curl 'https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-mocha.rasi' -o ~/.local/share/rofi/themes/catppuccin-mocha.rasi

curl https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.config/rofi/config.rasi -o ~/.config/rofi/config.rasi 
