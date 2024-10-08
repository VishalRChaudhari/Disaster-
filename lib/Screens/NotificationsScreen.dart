import 'package:flutter/material.dart';

class Notificationsscreen extends StatefulWidget {
  const Notificationsscreen({super.key});

  @override
  State<Notificationsscreen> createState() => _NotificationsscreenState();
}

class _NotificationsscreenState extends State<Notificationsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 255, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 220, 98),
        elevation: 10,
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('No Notifications...'),
      ),
    );
  }
}
