import 'package:disastermanagement/Widgets/news.dart';
import 'package:disastermanagement/Widgets/weatherCard.dart';
import 'package:flutter/material.dart';

class DisasterPage extends StatefulWidget {
  const DisasterPage({super.key});

  @override
  State<DisasterPage> createState() => _DisasterPage();
}

class _DisasterPage extends State<DisasterPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //search location
          Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                label: Text('Search City'),
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //hello card
          
          SizedBox(
            width: double.infinity,
            height: 110,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello...',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Vishal',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //location fetch
          SizedBox(
            height: 10,
          ),
          //weather display
          WeatherCard(),
          SizedBox(
            height: 10,
          ),
          Text(
            ' News',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: News(),
          ),
        ],
      ),
    );
  }
}
