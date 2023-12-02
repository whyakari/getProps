# GetProps 
> get pif from Google Pixel images!

## Usage (Local)
<details>
<summary>Instructions</summary>

1. Install packages dos2unix python3 python3-pip

2. Install protobuf
```bash
pip install --upgrade pip
pip3 install -Iv protobuf==3.20.3
```
3. Make executable all script, run:
```
chmod +x *.sh
```

4. Download last ota _device_name_, run:
```
./download_last_ota_build.sh device_name
```

5. Extract Image and build.prop, run:
```
./extract_images.sh
```

6. Get your custom_pif.json
```
./gen_custom_pif.sh json your_build.prop
```

</details>

# Credits
- [0x11DFE](https://github.com/Pixel-Props) by build-prop files
- [osm0sis](https://github.com/osm0sis) by file gen_pif_custom.sh
- [chiteroman](https://github.com/chiteroman) original idea
