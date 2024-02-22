import 'package:flutter/material.dart';

class ValidationLocation extends StatefulWidget {
  static const String routeName = '/validationLocation'; // Ajout du getter routeName
  const ValidationLocation({super.key});

  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation ok'), // Correction ici
      ), // Correction ici
    ); // Correction ici
  }
}
