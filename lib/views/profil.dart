import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  static const String routeName = '/profil'; // Ajout du getter routeName
  const Profil({Key? key}) : super(key: key); // Correction ici

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil à faire'), // Correction ici
      ), // Correction ici
    ); // Correction ici
  }
}
