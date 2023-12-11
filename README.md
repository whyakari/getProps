# GetProps 
> get your pif custom! (google pixel images)

### About other custom images
- now we have zenfone images and pixel images
- other images will be added soon.

# Others Brand
- [✅] Xiaomi (the add more devices)
- [✅] Google Pixel (completed)
- [✅] Asus Zenfone (the add more devices)
- [❌] Samsung (not added yet)
> add other brands

## Usage (Local)
<details>
<summary>Instructions</summary>

### Requirements (preferably)
- Linux

1. Install packages dos2unix python3 python3-pip
```
apt install dos2unix python3 python3-pip
```
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

## Usage (Actions)
[here](https://github.com/whyakari/getProps/actions)

# Credits
- [0x11DFE](https://github.com/Pixel-Props) by build-prop files
- [osm0sis](https://github.com/osm0sis) by file gen_pif_custom.sh
- [chiteroman](https://github.com/chiteroman) original idea

# How to contribute
1. clone this repository by forking
2. add other brands in `api/brand`
3. test locally with flask (assuming that everything is in order.)
4. (not yet) enable your fork's CI and do a test
5. Lastly send your PR's and I will check.
