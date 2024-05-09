import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_x/models/weather_model.dart';
import 'package:weather_x/services/weather_service.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final _weatherService = WeatherService('8dd69690f06a475c9d4120011240905');
  Weather? _weather;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getCurrentWeather('Omsk');
      setState(() {
        _weather = weather;
        print(weather.temperatureC.toString());
      });
    }

    catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          _currentWeatherSection(),
        ],
      )
    );
  }

  Column _currentWeatherSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left:20),
          child: Text(
            'Прямо сейчас',
            style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/condition_icon_1.svg',
              height: 64,
              width: 64,
            ),
            Text(
              '${_weather?.temperatureC.toString()}°C',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ],
    );
  }

  AppBar appBar(){
    return AppBar(
        title: const Text(
          'Russia, Omsk',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(8.0),
            child: Divider(
              color: Colors.orangeAccent,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            )
        )
    );
  }
}