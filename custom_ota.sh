#!/bin/bash

[ -f "util_functions.sh" ] && . ./util_functions.sh || { echo "util_functions.sh not found" && exit 1; }

if [ -z "$1" ]; then
  print_message "No ota device name provided to be downloaded" error
  exit 1
fi

for device_name in "${@}"; do
  print_message "Downloading ($device_name)..." debug

  python3 custom_ota_download.py "$device_name"
  
  print_message "Downloading OTA for \"$device_name\"..." debug
  python3 custom_ota_download.py "$device_name"

  print_message "Done downloading for \"$device_name\"" debug
done

print_message "Done. You can now extract/dump the image." info
