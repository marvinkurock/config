[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
exec i3
