#!/usr/bin/env python

import requests
import subprocess


# gets the public ipv4 address of the device
def get_ip_addr() -> str:
    out = subprocess.getoutput("curl api.ipify.org")
    # there are multiple lines as output
    out = out.split("\n")
    # the ip address is inside the last line
    return out[-1]


# geolocate the ip address using external service
def geolocate_ip(ip: str) -> dict:
    url = "https://ipinfo.io/" + ip + "/json"
    data = requests.get(url).json()
    return data


# extract city from geolocation and replace umlauts
def extr_city(data: dict, default: str) -> str:
    city = ""
    try:
        city = data["city"]
    except:
        city = default
    umlauts = {"Ä": "Ae", "Ö": "Oe", "Ü": "Ue", "ä": "ae", "ö": "oe", "ü": "ue", "ß": "ss"}
    for umlaut in umlauts.keys():
        try:
            city = city.replace(umlaut, umlauts[umlaut])
        except:
            pass
    return city


if __name__ == "__main__":
    ipv4_addr = get_ip_addr()
    print("IPv4: ", ipv4_addr, " ", type(ipv4_addr))
    print("City: ", extr_city(geolocate_ip(ipv4_addr), ""))
