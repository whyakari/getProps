import sys
from os import system
from requests import get

def get_zenfone():
    r = get("http://127.0.0.1:5000/v1/asus/zenfone").json()
    return r["zenfone"]

args = sys.argv[1:][0]
name = get_zenfone()[f"{args}"]

model = name["model"]
download_url = name["download_url"]
print(model)
print(download_url)

def download_device(model: str, d: str):
    file = f"https://dlcdnets.asus.com/pub/ASUS/ZenFone/{model}/{d}"
    system(f"wget {file}")

get_download = download_device(
    model=model,
    d=download_url
)

