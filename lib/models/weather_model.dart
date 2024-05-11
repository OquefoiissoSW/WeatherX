class Weather {
  final String countryName;
  final String region;
  final String cityName;
  final double temperatureC;
  final double temperatureF;
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
      required this.pressure
      });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      countryName: json['location']['country'],
      region: json['location']['region'],
      cityName: json['location']['name'],
      temperatureC: json['current']['temp_c'],
      temperatureF: json['current']['temp_f'],
      condition: json['current']['condition']['text'],
      humidity: json['current']['humidity'],
      wind_speed: json['current']['wind_kph'],
      wind_direction: json['current']['wind_dir'],
      pressure: json['current']['pressure_mb']
    );
  }
}

class DayForecast {
  final dynamic forecastsByHour;

  DayForecast({required this.forecastsByHour});

  factory DayForecast.fromJson(Map<String, dynamic> json) {
    return DayForecast(
        forecastsByHour: json['forecast']['forecastday']
    );
  }
}

class WeekForecast {
  final dynamic forecastByDay;

  WeekForecast({required this.forecastByDay});

  factory WeekForecast.fromJson(Map<String, dynamic> json) {
    return WeekForecast(
        forecastByDay: json['forecast']['forecastday']
    );
  }
}

class HourForecast {
  final double temperatureC;
  final double wind_speed;
  final String wind_direction;

  HourForecast ({
    required this.temperatureC,
    required this.wind_speed,
    required this.wind_direction
  });
}
