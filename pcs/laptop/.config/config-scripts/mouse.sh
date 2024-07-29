#! /bin/bash
get_pointer_id() {
  name="$1"
  xinput | grep "$name.*pointer" | awk -F'\t' '{ print $2 }' | cut -d'=' -f2
}

declare -a mice=("MX Master3" "Logitech USB Receiver Mouse")

# mouse_id=$(get_pointer_id "MX Master3")
# mouse2_id=$(get_pointer_id "Logitech USB Receiver Mouse")
touchpad_id=$(get_pointer_id "Touchpad")

for x in "${mice[@]}"; do
  mouse_id=$(get_pointer_id "$x")
  if [ ! -z "$mouse_id" ]; then
    echo "configuring $x"
    xinput --set-prop $mouse_id "libinput Accel Profile Enabled" 0 1 0
    xinput --set-prop $mouse_id "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 2
  fi
done

xinput --set-prop $touchpad_id "libinput Scrolling Pixel Distance" 45
xinput --set-prop $touchpad_id "libinput Natural Scrolling Enabled" 1
