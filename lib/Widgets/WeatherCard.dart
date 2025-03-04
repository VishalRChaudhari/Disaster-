import 'package:disastermanagement/sec.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/weather.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  final WeatherFactory _wf = WeatherFactory(weatherApiKey);
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
    return SizedBox(
      
      height: 150,
      width: double.infinity,
      child: Card(  
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
    
       color : Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _weather == null ? 'Loading...' : "${_weather?.areaName}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.temperatureHigh,
                      size: 18, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    _weather == null
                        ? ' - °C '
                        : '${_weather?.temperature?.celsius?.toStringAsFixed(1)}° C',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // ignore: deprecated_member_use
                  const Icon(FontAwesomeIcons.tint,
                      size: 18, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(_weather == null ? '-' : "${_weather?.humidity}%",
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }











































/*
  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _conditionCard(),
          _tempCard(),
          _humidity(),
        ],
      ),
    );


  Widget _conditionCard() {
    return SizedBox(
      height: 160,
      width: 140,
      child: Card(
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
        color: const Color.fromARGB(255, 145, 249, 148),
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
  */
}
