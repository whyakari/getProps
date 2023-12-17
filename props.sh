#!/bin/bash

[ -f "util_functions.sh" ] && . ./util_functions.sh || { echo "util_functions.sh not found" && exit 1; }

[ ! -z $1 ] && dir=$1 || {
	for dir in ./*; do      # List directory ./*
		if [ -d "$dir" ]; then # Check if it is a directory
			dir=${dir%*/}         # Remove last /
			print_message "Processing \"${dir##*/}\"" debug

			# Build system.prop
			./"${BASH_SOURCE[0]}" "$dir"
		fi
	done
	exit 1
}

product_path="$dir/extracted/product/etc/build.prop"
vendor_path="$dir/extracted/vendor/build.prop"
vendor_odm_path="$dir/extracted/vendor/odm/etc/build.prop"
system_path="$dir/extracted/system/system/build.prop"
system_path_2="$dir/extracted/system/build.prop"
system_ext_path="$dir/extracted/system_ext/etc/build.prop"

system_prop=""
module_prop=""

# Build our system.prop
to_system_prop "##
# Beautiful Pixel Props
# 
# group t.me/MoeKernelDiscussion
# channel t.me/MoeKernel
# ----- By @whyakari -----
##

# begin common build properties"

build_prop to_system_prop "$product_path" "ro.build.id"
build_prop to_system_prop "$product_path" "ro.build.version.security_patch"
build_prop to_system_prop "$product_path" "ro.build.date.utc"
build_prop to_system_prop "$product_path" "ro.product.model"
build_prop to_system_prop "$product_path" "ro.product.brand"
build_prop to_system_prop "$product_path" "ro.product.name"
build_prop to_system_prop "$product_path" "ro.product.manufacturer"
build_prop to_system_prop "$product_path" "ro.build.product"
build_prop to_system_prop "$product_path" "ro.build.fingerprint"
build_prop to_system_prop "$product_path" "ro.product.board"
build_prop to_system_prop "$product_path" "ro.build.tem.date"
build_prop to_system_prop "$product_path" "ro.product.device"
build_prop to_system_prop "$product_path" "ro.product.carrier"

build_prop to_system_prop "$system_path_2" "ro.build.id"
build_prop to_system_prop "$system_path_2" "ro.build.version.security_patch"
build_prop to_system_prop "$system_path_2" "ro.build.date.utc"
build_prop to_system_prop "$system_path_2" "ro.product.model"
build_prop to_system_prop "$system_path_2" "ro.product.brand"
build_prop to_system_prop "$system_path_2" "ro.product.name"
build_prop to_system_prop "$system_path_2" "ro.product.manufacturer"
build_prop to_system_prop "$system_path_2" "ro.build.product"
build_prop to_system_prop "$system_path_2" "ro.build.fingerprint"
build_prop to_system_prop "$system_path_2" "ro.product.board"
build_prop to_system_prop "$system_path_2" "ro.build.tem.date"
build_prop to_system_prop "$system_path_2" "ro.product.device"
build_prop to_system_prop "$system_path_2" "ro.product.carrier"

build_prop to_system_prop "$system_path" "ro.build.id"
build_prop to_system_prop "$system_path" "ro.build.version.security_patch"
build_prop to_system_prop "$system_path" "ro.build.date.utc"
build_prop to_system_prop "$system_path" "ro.product.model"
build_prop to_system_prop "$system_path" "ro.product.brand"
build_prop to_system_prop "$system_path" "ro.product.name"
build_prop to_system_prop "$system_path" "ro.product.manufacturer"
build_prop to_system_prop "$system_path" "ro.build.product"
build_prop to_system_prop "$system_path" "ro.build.fingerprint"
build_prop to_system_prop "$system_path" "ro.product.board"
build_prop to_system_prop "$system_path" "ro.build.tem.date"
build_prop to_system_prop "$system_path" "ro.product.device"
build_prop to_system_prop "$system_path" "ro.product.carrier"

# Save the system.prop file
echo -n "${system_prop::-1}" >"$dir/system.prop"

# Display information about prop
print_message "[$device_build_description] ($device_name) Prop" debug

build_info="[$device_build_description] ($device_name) Prop"
device_build_description=$(echo "$build_info" | grep -oP '\d+\s+\w+\.\d+\.\d+')
device_name=$(echo "$build_info" | grep -oP '\(([^)]+)\)' | sed 's/[()]//g' | sed 's/ //g')
device_build_description=$(echo "$device_build_description" | sed 's/\([0-9]\)\s\+\([A-Z]\)/\1-\2/g')
device_build_description=$(echo "$device_build_description" | sed 's/\(.*\.[0-9]\{6\}\).*$/\1/')
echo "$device_name-A$device_build_description" > build.txt

echo "[$device_build_description] ($device_name) Prop"

# Display saving location
print_message "Saved to \"${dir}/system.prop\"" info
print_message "Saved to \"${dir}/module.prop\"" info
