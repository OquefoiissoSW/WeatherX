import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_x/pages/forecast.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  bool showForecast = false;

  final _weatherService = WeatherService('8dd69690f06a475c9d4120011240905');

  late Weather _weather;
  late Forecast _dayForecast;
  late Forecast _weekForecast;

  _fetchWeather(BuildContext context) async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getCurrentWeather(cityName);
      final dayForecast = await _weatherService.getForecast(cityName, 1);
      final weekForecast = await _weatherService.getForecast(cityName, 7);
      setState(() {
        _weather = weather;
        _dayForecast = dayForecast;
        _weekForecast = weekForecast;
        showForecast = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather(context);
  }

  @override
  Widget build(BuildContext context) {
    if (showForecast) {
      return ForecastPage(
        weather: _weather,
        dayForecast: _dayForecast,
        weekForecast: _weekForecast,
      );
    } else {
      return Scaffold(
        body: ListView(
          children: [
            Center(
                child: Lottie.asset('assets/cloud.json',
                    width: 120, height: 120)),
            const Center(
              child: Text(
                "Loading..",
                style: TextStyle(fontSize: 32),
              ),
            )
          ],
        ),
      );
    }
  }
}
