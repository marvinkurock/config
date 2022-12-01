choice=$(echo -n 'Shutdown\nRestart\nLogout' | rofi -dmenu)
echo $choice

case $choice in
  'Shutdown') poweroff ;;
  'Restart') restart ;;
  'Logout') i3-msg exit ;;
esac
