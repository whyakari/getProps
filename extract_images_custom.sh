#!/bin/bash

[ -f "util_functions.sh" ] && . ./util_functions.sh || { echo "util_functions.sh not found" && exit 1; }

print_message "Extracting images from archives..." info
for file in ./*; do
    if [ -f "$file" ]; then
        if [ "${file: -4}" == ".zip" ]; then
            filename="${file##*/}"
            basename="${filename%.*}"
            devicename="${basename%%-*}"
            print_message "Processing \"$filename\"" debug

            extraction_start=$(date +%s)

            if [[ ! "${basename##"$devicename"-ota-*}" ]]; then
                7z e "$file" -o "extracted_archive_images" "payload.bin" -r &>/dev/null
                mv -f "extracted_archive_images/payload.bin" "extracted_archive_images/$basename.bin"
            else
                7z e "$file" -o "extracted_archive_images" "*/*.zip" -r -y &>/dev/null
            fi

            rm "$file"

            extraction_end=$(date +%s)
            extraction_runtime=$((extraction_end - extraction_start))

            print_message "Extraction time: $extraction_runtime seconds" debug
        fi
    fi
done

if [ -d "extracted_archive_images" ]; then
    print_message "\nExtracting/Dumping images from \"extracted_archive_images\"..." info

    for file in ./extracted_archive_images/*; do
        if [ -f "$file" ]; then
            if [ "${file: -4}" == ".zip" ] || [ "${file: -4}" == ".bin" ]; then
                filename="${file##*/}"
                basename="${filename%.*}"
                print_message "Processing \"$filename\"" debug

                extraction_start=$(date +%s)

                if [ "${file: -4}" == ".bin" ]; then
                    python3 ota_dumper/extract_android_ota_payload.py "$file" "extracted_images/$basename"
                else
                    for image_name in "${IMAGES2EXTRACT[@]}"; do
                        print_message "Extracting \"$image_name\"..." debug
                        7z e "$file" -o"extracted_images/$basename" "$image_name.img" -r &>/dev/null
                    done
                fi

                extraction_end=$(date +%s)
                extraction_runtime=$((extraction_end - extraction_start))

                print_message "Extraction time: $extraction_runtime seconds" debug
            fi
        fi
    done

    rm -rf "extracted_archive_images"
fi

print_message "\nExtracting images and directories..." info
for dir in ./extracted_images/*; do
    if [ -d "$dir" ]; then
        dir=${dir%*/}
        print_message "Processing \"${dir##*/}\"" debug

        extraction_start=$(date +%s)

        for image_name in "${IMAGES2EXTRACT[@]}"; do
            extract_image "$dir" "$image_name"
            rm "$dir/$image_name.img"
        done

        extraction_end=$(date +%s)
        extraction_runtime=$((extraction_end - extraction_start))

        print_message "Extraction time: $extraction_runtime seconds" debug

        print_message "Building props..." info
        ./build_props.sh "$dir"
    fi
done

