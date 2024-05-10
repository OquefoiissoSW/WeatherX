import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:weather_x/models/maps.dart';
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
    } catch (e) {
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
        ));
  }

  Column _currentWeatherSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 5),
          child: Text(
            'Прямо сейчас',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        CarouselSlider(items: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 21),
                child: Text(
                  '${conditions[_weather?.condition]}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/icons/condition/condition_${_weather?.condition.toLowerCase().replaceAll(RegExp(' '), '_')}.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Text(
                    '${_weather?.temperatureC.toString()}°C',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/wind_speed.png',
                      height: 32,
                      width: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      'Скорость ветра ${_weather?.wind_speed}км/ч c ${directions[_weather?.wind_direction]}а',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/humidity.png',
                      height: 32,
                      width: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      'Влажность ${_weather?.humidity}%',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/pressure.png',
                      height: 32,
                      width: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      'Давление ${(_weather!.pressure * 0.7506).round()}мм. рт. ст',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          )
        ], options: CarouselOptions(viewportFraction: 1)),
      ],
    );
  }

  AppBar appBar() {
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
            )));
  }
}
