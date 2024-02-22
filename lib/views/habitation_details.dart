import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/resa_location.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';
import '../models/habitation.dart';
import '../share/location_style.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importez cette bibliothèque

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  void initState() {
    super.initState();
    // Initialisez la localisation des formats de date pour la locale actuelle
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
          SizedBox(
            height: 8.0,
          ),
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8.0),
                      Text(
                        "Options",
                        style: LocationTextStyle.subTitleboldTextStyle,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 36.0,
                          child: Divider(
                            color: Colors.black, // Couleur de votre choix
                            thickness: 1.0, // Épaisseur de votre choix
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildItems(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8.0),
                      Text(
                        "Options payantes",
                        style: LocationTextStyle.subTitleboldTextStyle,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 36.0,
                          child: Divider(
                            color: Colors.black, // Couleur de votre choix
                            thickness: 1.0, // Épaisseur de votre choix
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildOptionsPayantes(),
              ],
            ),
          ),
          _buildRentButton(),
        ],
      ),
    );
  }

  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
              style: LocationTextStyle.regularWhiteTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResaLocation(widget._habitation)),
                );
              },
              child: Text('Louer'),
            ),
          ),
        ],
      ),
    );
  }

  _buildItems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;
    return Wrap(
      children: Iterable.generate(
        widget._habitation.options.length,
            (i) => Container(
          width: width,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._habitation.options[i].libelle),
              Text(
                widget._habitation.options[i].description,
                style: LocationTextStyle.regularGreyTextStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }

  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;
    return Wrap(
      children: Iterable.generate(
        widget._habitation.optionspayantes.length,
            (i) => Container(
          width: width,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget._habitation.optionspayantes[i].libelle),
              Text(
                widget._habitation.optionspayantes[i].prix.toString(),
                style: LocationTextStyle.regularGreyTextStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }
}
