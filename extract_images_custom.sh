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
for file in "$extracted_dir"/*; do
    if [ -f "$file" ]; then
        filename="${file##*/}"
        basename="${filename%.*}"

        if [ "$basename" != "payload" ]; then
            mv -f "$file" "$extracted_dir/$basename.bin"

        fi
    fi
done

echo "Extração concluída. Arquivos movidos para: $extracted_dir"

# Dumping
for file in "$extracted_dir"/*; do
    if [ -f "$file" ] && [ "${file: -4}" == ".bin" ]; then
        filename="${file##*/}"
        basename="${filename%.*}"

        if [ ! -f "extracted_images/$basename" ]; then
			rm -f "extracted_images/$basename/payload" "extracted_images/$basename/apex_info" "extracted_images/$basename/care_map" "extracted_images/$basename/payload_properties"
            print_message "Dumping \"$basename\"..." debug
            python3 ota_dumper/extract_android_ota_payload.py "$file" "extracted_images/$basename"
        else
            print_message "O arquivo \"$basename\" já existe. Pulando a extração/dump." debug
        fi
    fi
done

