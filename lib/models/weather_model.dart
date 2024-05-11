class Weather {
  final String countryName;
  final String region;
  final String cityName;
  final double temperatureC;
  final double temperatureF;
  final dynamic feels_like;
  final String condition;
  final int humidity;
  final double wind_speed;
  final String wind_direction;
  final double pressure;

  Weather(
      {required this.countryName,
      required this.region,
      required this.cityName,
      required this.temperatureC,
      required this.temperatureF,
      required this.condition,
      required this.humidity,
      required this.wind_speed,
      required this.wind_direction,
      required this.pressure,
      required this.feels_like});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        countryName: json['location']['country'],
        region: json['location']['region'],
        cityName: json['location']['name'],
        temperatureC: json['current']['temp_c'],
        temperatureF: json['current']['temp_f'],
        feels_like: json['current']['feelslike_c'],
        condition: json['current']['condition']['text'],
        humidity: json['current']['humidity'],
        wind_speed: json['current']['wind_kph'],
        wind_direction: json['current']['wind_dir'],
        pressure: json['current']['pressure_mb']);
  }
}

class Forecast {
  final dynamic forecastsByHour;

  Forecast({required this.forecastsByHour});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(forecastsByHour: json['forecast']['forecastday']);
  }
}
