#!/bin/bash

if [ -z "$1" ]; then
  echo "No ota device name provided to be downloaded" >&2
  exit 1
fi

args="$1"
name=$(curl -s "http://127.0.0.1:5000/v1/asus/zenfone" | jq -r ".$args")

model=$(echo "$name" | jq -r '.model')
download_url=$(echo "$name" | jq -r '.download_url')

echo "$model"
echo "$download_url"

function download_device() {
    file="https://dlcdnets.asus.com/pub/ASUS/ZenFone/$1/$2"
    wget "$file"
}

download_device "$model" "$download_url"

