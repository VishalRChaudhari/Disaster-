import 'package:disastermanagement/Widgets/WeatherCard.dart';
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
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //hello card
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Card(            
              elevation: 10,
              color: Color.fromARGB(255, 197, 241, 199),
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello...'),
                    Text(
                      'Vishal',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //search location
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 173, 248, 177),
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

          //location fetch
          
          SizedBox(
            height: 10,
          ),
          //weather display
          WeatherCard(),
        ],
      ),
    );
  }
}
