import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({required this.searchtext, super.key});

  final String searchtext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: searchtext,
        contentPadding: const EdgeInsets.all(15),
      ),
    );
  }
}
