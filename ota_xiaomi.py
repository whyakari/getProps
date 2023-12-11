from sys import argv
from os import system
from requests import get

device = argv[1]

def get_url(device: str):
    r = get(f"http://127.0.0.1:5000/v1/xiaomi/{device}").json()
    url = r[device] 
    system(f"wget {url}")

get_url(device)
