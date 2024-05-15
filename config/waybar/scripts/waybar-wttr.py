#!/usr/bin/env python

# standard library imports
import json
import requests
from datetime import datetime

# custom imports
import ip_addr


WEATHER_CODES = {
    '113': '☀️',
    '116': '⛅️',
    '119': '☁️',
    '122': '☁️',
    '143': '🌫',
    '176': '🌦',
    '179': '🌧',
    '182': '🌧',
    '185': '🌧',
    '200': '⛈',
    '227': '🌨',
    '230': '❄️',
    '248': '🌫',
    '260': '🌫',
    '263': '🌦',
    '266': '🌦',
    '281': '🌧',
    '284': '🌧',
    '293': '🌦',
    '296': '🌦',
    '299': '🌧',
    '302': '🌧',
    '305': '🌧',
    '308': '🌧',
    '311': '🌧',
    '314': '🌧',
    '317': '🌧',
    '320': '🌨',
    '323': '🌨',
    '326': '🌨',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧',
    '353': '🌦',
    '356': '🌧',
    '359': '🌧',
    '362': '🌧',
    '365': '🌧',
    '368': '🌨',
    '371': '❄️',
    '374': '🌧',
    '377': '🌧',
    '386': '⛈',
    '389': '🌩',
    '392': '⛈',
    '395': '❄️'
}

data = {}


ipv4_addr = ip_addr.get_ip_addr()
city = ip_addr.extr_city(ip_addr.geolocate_ip(ipv4_addr), "Düsseldorf")

weather = requests.get("https://wttr.in/" + city + "?format=j1").json()


def celsius_to_kelvin(temp):
    KELVIN = 271.15
    return str(KELVIN + int(temp))


def format_time(time):
    return time.replace("00", "").zfill(2)


def format_temp(temp):
    return (celsius_to_kelvin(hour['FeelsLikeC'])+"K").ljust(3)


def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)


data['text'] = weather['nearest_area'][0]['areaName'][0]['value'] + ": " + \
    WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
    " "+celsius_to_kelvin(weather['current_condition'][0]['FeelsLikeC'])+"K" 

data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {celsius_to_kelvin(weather['current_condition'][0]['temp_C'])}K</b>\n"
data['tooltip'] += f"Feels like: {celsius_to_kelvin(weather['current_condition'][0]['FeelsLikeC'])}K\n"
data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
for i, day in enumerate(weather['weather']):
    data['tooltip'] += f"\n<b>"
    if i == 0:
        data['tooltip'] += "Today, "
    if i == 1:
        data['tooltip'] += "Tomorrow, "
    data['tooltip'] += f"{day['date']}</b>\n"
    data['tooltip'] += f"⬆️ {celsius_to_kelvin(day['maxtempC'])}K ⬇️ {celsius_to_kelvin(day['mintempC'])}K "
    data['tooltip'] += f"🌅 {day['astronomy'][0]['sunrise']} 🌇 {day['astronomy'][0]['sunset']}\n"
    for hour in day['hourly']:
        if i == 0 and int(format_time(hour['time'])) < datetime.now().hour-2:
            continue
        data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_temp(hour['FeelsLikeC'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"

print(json.dumps(data))
