get_pointer_id() {
  name="$1"
  xinput | grep "$name.*pointer" | awk -F'\t' '{ print $2 }' | cut -d'=' -f2
}


mouse_id=$(get_pointer_id "MX Master3")
touchpad_id=$(get_pointer_id "Touchpad")

xinput --set-prop $mouse_id 339 0 1 0
xinput --set-prop $mouse_id 197 1 0 0 0 1 0 0 0 2

xinput --set-prop $touchpad_id 351 45
xinput --set-prop $touchpad_id 325 1
