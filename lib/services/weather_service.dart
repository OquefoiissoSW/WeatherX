import 'dart:convert';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.weatherapi.com/v1';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getCurrentWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL/current.json?key=$apiKey&q=$cityName&aqi=no'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data: ${response.statusCode}");
    }
  }
}