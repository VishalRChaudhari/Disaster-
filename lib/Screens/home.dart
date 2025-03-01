import 'package:disastermanagement/Screens/notifications_screen.dart';
import 'package:disastermanagement/Screens/disaster_register.dart';
import 'package:disastermanagement/Screens/map_screen.dart';
import 'package:disastermanagement/Widgets/disaster_page.dart';
import 'package:disastermanagement/Screens/helpline.dart';
import 'package:disastermanagement/Screens/profile.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    String title = 'Sanjeevani';
    Widget? content;
    if (currentIndex == 0) {
      content = const Center(child: DisasterPage());
    }
    if (currentIndex == 1) {
      //helpline contacts list
      title = 'Location Details';
      content = const Center(
        child: MapScreen(),
      );
    }
    if (currentIndex == 2) {
      //helpline contacts list
      title = 'Register Disaster';
      content = const Center(
        child: RegisterPage(),
      );
    }
    if (currentIndex == 3) {
      //helpline contacts list
      title = 'Helpline Contact ';
      content = const Center(
        child: SingleChildScrollView(
          child: HelpCard(),
        ),
      );
    }
    if (currentIndex == 4) {
      title = 'Profile';
      //profile content
      content = const Center(
        child: ProfilePage(),
      );
    }

    return Scaffold(
      backgroundColor : Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(title),
        elevation: 50,
        actions: [
          if (currentIndex == 0 || currentIndex == 4 || currentIndex == 3)
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Notificationsscreen(),
                ));
              },
              icon: const Icon(Icons.notifications_outlined),
            ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        fixedColor: Theme.of(context).colorScheme.secondary,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 1, 57, 3),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
              color: Color.fromARGB(255, 1, 57, 3),
            ),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Color.fromARGB(255, 1, 57, 3),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.phone,
              color: Color.fromARGB(255, 1, 57, 3),
            ),
            label: 'Helpline',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 1, 57, 3),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: content,
    );
  }
}
