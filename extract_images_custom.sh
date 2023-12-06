#!/bin/bash

zip_file=$(find . -maxdepth 1 -type f -name "*.zip" -print -quit)

if [ -z "$zip_file" ]; then
    echo "Nenhum arquivo .zip encontrado no diretório atual."
    exit 1
fi

extracted_dir="extracted_images"

mkdir -p "$extracted_dir"

unzip -o "$zip_file" -d "$extracted_dir" &>/dev/null

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

