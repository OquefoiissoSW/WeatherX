import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_x/models/maps.dart';
import 'package:weather_x/models/weather_model.dart';
import 'package:weather_x/services/weather_service.dart';
import 'dart:math' as math;

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final _weatherService = WeatherService('8dd69690f06a475c9d4120011240905');
  Weather? _weather;
  DayForecast? _dayForecast;
  WeekForecast? _weekForecast;
  RegExp dirExp = RegExp(r"[^А-Я]+");

  _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getCurrentWeather(cityName);
      final dayForecast = await _weatherService.getDayForecast(cityName);
      final weekForecast = await _weatherService.getWeekForecast(cityName);
      setState(() {
        _weather = weather;
        _dayForecast = dayForecast;
        _weekForecast = weekForecast;
        print(_weekForecast?.forecastByDay[0]['day']['maxtemp_c']);
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
          children: [_currentWeatherSection(), _dayForecastSelection(), _weekForecastSelection()],
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
                      'assets/icons/condition/condition_${_weather?.condition.toLowerCase().replaceAll(RegExp(' '), '_') ?? "clear"}.png',
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          border:
                              Border.all(width: 6, color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/icons/wind_speed.png',
                        height: 32,
                        width: 32,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      'Скорость ветра ${((_weather?.wind_speed ?? 0) / 3.6).toStringAsFixed(2)}м/с',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          border:
                              Border.all(width: 6, color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/icons/wind_direction.png',
                        height: 32,
                        width: 32,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      'В направлении ${directions[_weather?.wind_direction]}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          border:
                              Border.all(width: 6, color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/icons/humidity.png',
                        height: 32,
                        width: 32,
                        color: Colors.white,
                      ),
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          border:
                              Border.all(width: 6, color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/icons/pressure.png',
                        height: 32,
                        width: 32,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                    ),
                    Text(
                      'Давление ${((_weather?.pressure ?? 0) * 0.7506).round()}мм. рт. ст',
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

  Column _dayForecastSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 5),
          child: Text(
            'Прогноз на день',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 160,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${_dayForecast?.forecastsByHour[index * 3]['temp_c']}°C',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Image.asset(
                          'assets/icons/condition/condition_${_dayForecast?.forecastsByHour[index * 3]["condition"]["text"].toLowerCase().trim().replaceAll(RegExp(' '), '_') ?? "clear"}.png',
                          height: 25,
                          width: 25,
                          color: Colors.white,
                        ),
                        Transform.rotate(
                          angle: (directionsAngle[_dayForecast
                                  ?.forecastsByHour[index * 3]['wind_dir']] ?? 0) *
                              math.pi /
                              180,
                          child: Icon(Icons.arrow_forward),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${_dayForecast?.forecastsByHour[index * 3]['wind_kph']}'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                '${directions[_dayForecast?.forecastsByHour[index * 3]['wind_dir']]?.replaceAll(dirExp, '')}')
                          ],
                        )
                      ],
                    ),
                  ),
                  Text('${index*3}:00')
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
            itemCount: 7,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  Column _weekForecastSelection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 5),
          child: Text(
            'Прогноз на неделю',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 160,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${_dayForecast?.forecastsByHour[index * 3]['temp_c']}°C',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Image.asset(
                          'assets/icons/condition/condition_${_dayForecast?.forecastsByHour[index * 3]["condition"]["text"].toLowerCase().trim().replaceAll(RegExp(' '), '_') ?? "clear"}.png',
                          height: 25,
                          width: 25,
                          color: Colors.white,
                        ),
                        Transform.rotate(
                          angle: (directionsAngle[_dayForecast
                              ?.forecastsByHour[index * 3]['wind_dir']] ?? 0) *
                              math.pi /
                              180,
                          child: Icon(Icons.arrow_forward),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${_dayForecast?.forecastsByHour[index * 3]['wind_kph']}'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                '${directions[_dayForecast?.forecastsByHour[index * 3]['wind_dir']]?.replaceAll(dirExp, '')}')
                          ],
                        )
                      ],
                    ),
                  ),
                  Text('${index*3}:00')
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
            itemCount: 7,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
        title: Text(
          ('${_weather?.cityName ?? ""}, ${_weather?.countryName ?? "loading city.."}'),
          style: const TextStyle(
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
