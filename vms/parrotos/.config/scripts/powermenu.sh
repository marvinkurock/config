choice=$(echo -n 'Shutdown\nRestart\nLogout' | rofi -dmenu)
echo $choice

case $choice in
  'Shutdown') systemctl poweroff ;;
  'Restart') systemctl reboot ;;
  'Logout') i3-msg exit ;;
esac
