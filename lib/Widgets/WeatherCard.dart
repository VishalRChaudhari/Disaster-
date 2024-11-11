import 'package:disastermanagement/secrets.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  final WeatherFactory _wf = WeatherFactory(WEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Pune").then(
      (value) {
        setState(() {
          _weather = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _conditionCard(),
          _tempCard(),
          _humidity(),
        ],
      ),
    );
  }

  Widget _conditionCard() {
    return SizedBox(
      height: 160,
      width: 140,
      child: Card(
        elevation: 10,
        color:  const Color.fromARGB(255, 145, 249, 148),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _weatherIcon(),
            _weatherState(),
            _cityname(),
          ],
        ),
      ),
    );
  }

  Widget _weatherState() {
    return Text(
      _weather == null ? ' ' : '${_weather?.weatherDescription}',
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }

  Widget _weatherIcon() {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
        ),
      ),
    );
  }

  Widget _cityname() {
    return Text(
      _weather == null ? 'Loading...' : "${_weather?.areaName}",
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }

  Widget _tempCard() {
    return SizedBox(
      height: 160,
      width: 140,
      child: Card(
        elevation: 10,
        color:  const Color.fromARGB(255, 145, 249, 148),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              _weather == null
                  ? ' - - '
                  : '${_weather?.temperature?.celsius?.toStringAsFixed(1)}° C',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _weather == null
                  ? ''
                  : "L: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
            ),
            Text(
              _weather == null
                  ? ''
                  : "H: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
            )
          ],
        ),
      ),
    );
  }

  Widget _humidity() {
    return SizedBox(
      height: 160,
      width: 140,
      child: Card(
        elevation: 10,
        color:  const Color.fromARGB(255, 145, 249, 148),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 85,
              width: 70,
              child: Image(
                image: AssetImage('lib/assets/images/humidity.png'),
              ),
            ),
            Text("${_weather?.humidity}"),
            const Text(
              'Humidity',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
