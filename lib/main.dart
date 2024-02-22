import 'package:flutter/material.dart';
import 'package:location/models/habitation.dart';
import 'package:location/models/habitations_data.dart';
import 'package:location/models/typehabitat.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:intl/intl.dart';
import 'package:location/views/habitation_details.dart';
import 'package:location/views/habitation_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/views/location_list.dart';
import 'package:location/views/login_page.dart';
import 'package:location/views/profil.dart';
import 'package:location/views/validation_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Mes locations'),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('fr')],
      routes: {
        Profil.routeName: (context) => const Profil(),
        LoginPage.routeName: (context) => const LoginPage('/'),
        LocationList.routeName: (context) => const LocationList(),
        ValidationLocation.routeName: (context) => const ValidationLocation(),
      }
    );

  }
}

class MyHomePage extends StatelessWidget {
  final HabitationService service = HabitationService();
  final String title;
  late List<TypeHabitat> _typehabitats;
  late List<Habitation> _habitations;

  MyHomePage({Key? key, required this.title}) : super(key: key) {
    _habitations = service.getHabitationsTop10();
    _typehabitats = service.getTypeHabitats();
  }


  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _typehabitats.length,
              (index) => _buildHabitat(context,_typehabitats[index]),
        ),
      ),
    );
  }

  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      // case 1 : House
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color:  LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HabitationList(typeHabitat.id == 1),
              ));
          },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white70,
            ),
            SizedBox(width : 5),
            Text(
              typeHabitat.libelle,
              style: LocationTextStyle.regularWhiteTextStyle,
            )
          ],
        ),
      ),
    ));
  }

  _buildDerniereLocation(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          itemCount: _habitations.length,
          itemExtent: 220,
          itemBuilder: (context, index) =>
              _buildRow(_habitations[index], context),
          scrollDirection: Axis.horizontal,
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    var format = NumberFormat("### €");

    return Container(
      width: 240,
        child: GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HabitationDetails(habitation)),
      );
    },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit : BoxFit.fitWidth,
            ),
          ),
          Text(
              habitation.libelle,
              style: LocationTextStyle.regularTextStyle,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text(
                  habitation.adresse,
                  style: LocationTextStyle.regularTextStyle,
              ),
            ],
          ),
          Text(
              format.format(habitation.prixmois),
              style: LocationTextStyle.boldTextStyle,
          ),
        ],
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTypeHabitat(context),
            SizedBox(height: 20),
            _buildDerniereLocation(context),
          ],
        )
      )
    );
  }
}

