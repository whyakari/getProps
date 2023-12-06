from requests import get

def get_zenfone():
    r = get("http://127.0.0.1:5000/v1/asus/zenfone").json()
    return r["zenfone"]

name = get_zenfone()["zenfone-8-flip"]
print(name)

model = name["model"]
download_url = name["download_url"]
print(model)
print(download_url)

def download_device(model: str, download_model_name: str):
    r = get(
        f"https://dlcdnets.asus.com/pub/ASUS/ZenFone/{model}/{download_model_name}"
    )
    print(r.text)

    with open(download_url, 'wb') as file:
        file.write(r.content)

get_download = download_device(
    model=model,
    download_model_name=download_url
)

print(get_download)
