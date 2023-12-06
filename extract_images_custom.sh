#!/bin/bash

[ -f "util_functions.sh" ] && . ./util_functions.sh || { echo "util_functions.sh not found" && exit 1; }

zip_file=$(find . -maxdepth 1 -type f -name "*.zip" -print -quit)

if [ -z "$zip_file" ]; then
    echo "Nenhum arquivo .zip encontrado no diretório atual."
    exit 1
fi

extracted_dir="extracted_images"

mkdir -p "$extracted_dir"
unzip -o "$zip_file" -d "$extracted_dir" &>/dev/null

# Extract
print_message "Extracting images from archives..." info
for file in "$extracted_dir"/*; do
    if [ -f "$file" ]; then
        filename="${file##*/}"
        basename="${filename%.*}"

        if [ "$basename" != "payload" ]; then
            mv -f "$file" "$extracted_dir/$basename.bin"
		else
			7z e "$file" -o "extracted_archive_images" "*/*.zip" -r -y &>/dev/null
		fi
    fi
done

# Dumping
for file in "$extracted_dir"/*; do
    if [ -f "$file" ] && [ "${file: -4}" == ".bin" ]; then
		print_message "\nExtracting/Dumping images from \"extracted_archive_images\"..." info

        filename="${file##*/}"
        basename="${filename%.*}"

        if [ ! -f "extracted_images/$basename" ]; then

			find "extracted_images/$basename" -type f \( -name "apex_info" -o -name "care_map" -o -name "payload_properties" -c -name "payload" \) -exec rm -f {} +

            print_message "Dumping \"$basename\"..." debug
            python3 ota_dumper/extract_android_ota_payload.py "$file" "extracted_images/$basename"
        else
			for image_name in "${IMAGES2EXTRACT[@]}"; do
				print_message "Extracting \"$image_name\"..." debug
				7z e "$file" -o"extracted_images/$basename" "$image_name.img" -r &>/dev/null
			done
		fi
    fi
done

# Extract the images directories
print_message "\nExtracting images and directories..." info

for file in ./extracted_dir*; do
    if [ -d "$dir" ]; then
        dir=${dir%*/}
        print_message "Processing \"${dir##*/}\"" debug

        for image_name in "${IMAGES2EXTRACT[@]}"; do
            extract_image "$file" "$image_name"
            rm "$file/$image_name.img"
        done

        print_message "Building props..." info
        ./build_props.sh "$file"
    fi
done

