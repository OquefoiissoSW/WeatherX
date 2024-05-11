import 'dart:collection';

final Map<String, String> conditions = {
  "Sunny": "Солнечно",
  "Clear": "Безоблачно",
  "Partly cloudy": "Переменно",
  "Cloudy": "Облачно",
  "Overcast": "Пасмурно",
  "Mist": "Туман",
  "Patchy rain possible": "Возможен кратковременный дождь",
  "Patchy snow possible": "Возможен кратковременный снег",
  "Patchy sleet possible": "Возможен кратковременный мокрый снег",
  "Patchy freezing drizzle possible": "Возможен кратковременный ледяной дождь",
  "Thundery outbreaks possible": "Возможны грозовые вспышки",
  "Blowing snow": "Метель",
  "Blizzard": "Метель",
  "Fog": "Туман",
  "Freezing fog": "Ледяной туман",
  "Patchy light drizzle": "Небольшой мелкий дождь",
  "Light drizzle": "Легкая морось",
  "Freezing drizzle": "Изморозь",
  "Heavy freezing drizzle": "Сильный ледяной дождь",
  "Patchy light rain": "Небольшой дождь",
  "Light rain": "Легкий дождь",
  "Moderate rain at times": "Временами умеренный дождь",
  "Moderate rain": "Дождь",
  "Heavy rain at times" : "Временами сильный дождь",
  "Heavy rain" : "Ливень"
};

final Map<String, String> directions = {
  "S": "Юг",
  "N": "Север",
  "W": "Запад",
  "E": "Восток",
  "SW": "Юго-Запад",
  "SE": "Юго-Восток",
  "NW": "Северо-Запад",
  "NE": "Северо-Восток",
  "SSW": "Юго-Запад",
  "WSW": "Юго-Запад",
  "WNW": "Северо-Запад",
  "NNW": "Северо-Запад",
  "NNE": "Северо-Восток",
  "ENE": "Северо-Восток",
  "ESE": "Юго-Восток",
  "SSE": "Юго-Восток"
};

final Map<String, double> directionsAngle = {
  "S": 90,
  "N": -90,
  "W": 180,
  "E": 0,
  "SW": 135,
  "SE": 45,
  "NW": -135,
  "NE": -45,
  "SSW": 135,
  "WSW": 135,
  "WNW": -135,
  "NNW": -135,
  "NNE": -45,
  "ENE": -45,
  "ESE": 45,
  "SSE": 45
};
