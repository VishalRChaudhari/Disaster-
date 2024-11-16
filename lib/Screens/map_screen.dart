import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Mapscreen extends StatelessWidget {
  const Mapscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    _onsubmit() {
      String name = nameController.text;
      if (name.isEmpty) {
        return;
      }
      FirebaseFirestore.instance.collection('name').add({
        'name': name,
      });
      
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          IconButton(onPressed: _onsubmit, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
