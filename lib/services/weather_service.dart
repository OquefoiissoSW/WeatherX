import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
      return Weather.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load weather data: ${response.statusCode}");
    }
  }

  Future<DayForecast> getDayForecast(String cityName, int days) async {
    final response = await http
        .get(Uri.parse('$BASE_URL/forecast.json?key=$apiKey&q=$cityName&days=$days&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      return DayForecast.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load weather data: ${response.statusCode}");
    }
  }

  Future<WeekForecast> getWeekForecast(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL/marine.json?key=$apiKey&q=$cityName&days=7'));

    if (response.statusCode == 200) {
      return WeekForecast.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load weather data: ${response.statusCode}");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }
}