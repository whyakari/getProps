#!/bin/bash

[ -f "util_functions.sh" ] && . ./util_functions.sh || { echo "util_functions.sh not found" && exit 1; }

if [ -z "$1" ]; then
  print_message "No ota device name provided to be downloaded" error
  exit 1
fi

android_version="tq3a" # e.g (Android 13)

print_message "Started downloading Android $android_version OTAs for: ($*)" info

for device_name in "${@}"; do
  last_build_url=$(curl -Ls 'https://developers.google.cn/android/ota?partial=1' | grep -Eo "\"(\S+$device_name\S{33})?zip" | grep "$android_version" | tail -1 | tr -d \")
  print_message "Downloading ($device_name) \"$last_build_url\"..." debug
  wget --tries=inf --show-progress -q "$last_build_url"
done

print_message "Done. You can now extract/dump the image." info
