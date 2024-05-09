class Weather {
  final String countryName;
  final String region;
  final String cityName;
  final double temperatureC;
  final double temperatureF;
  final String condition;

  Weather({
    required this.countryName,
    required this.region,
    required this.cityName,
    required this.temperatureC,
    required this.temperatureF,
    required this.condition
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        countryName: json['location']['country'],
        region: json['location']['region'],
        cityName: json['location']['name'],
        temperatureC: json['current']['temp_c'],
        temperatureF: json['current']['temp_f'],
        condition: json['current']['condition']['text']
    );
  }
}