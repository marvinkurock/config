#! /bin/bash

id=13

state=$(xinput list-props $id | grep "Device Enabled" | cut -d: -f2 | tr -d '[:space:]')
echo $state
if [[ "$state" == "1" ]]; then
  xinput disable $id
else
  xinput enable $id
fi
