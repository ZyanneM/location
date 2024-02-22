import 'package:flutter/material.dart';

class LocationList extends StatefulWidget {
  static const String routeName = '/locationList'; // Ajout du getter routeName
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocationList'), // Correction ici
      ), // Correction ici
    ); // Correction ici
  }
}
