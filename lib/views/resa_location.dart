import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';

class ResaLocation extends StatefulWidget {
  final Habitation habitation;
  const ResaLocation(this.habitation, {super.key});

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class OptionPayanteCheck extends OptionPayante {
  bool checked;

  OptionPayanteCheck(super.id, super.libelle, this.checked,
      {super.description = "", super.prix});
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<OptionPayanteCheck> optionPayanteChecks = [];
  List<int> nbPersonnesList = List.generate(8, (index) => index + 1);
  int selectedNbPersonnes = 1;

  var format = NumberFormat('### €');

  @override
  void initState() {
    super.initState();
    _loadOptionPayantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation'),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          TotalWidget(
            prixTotal: calculateTotalPrice(),
          ),
          _buildRentButton(),
        ],
      ),
    );
  }

  double calculateTotalPrice() {
    int numberOfNights = dateFin
        .difference(dateDebut)
        .inDays;
    double pricePerNight = widget.habitation.prixmois / 30;
    double totalPrice = numberOfNights * pricePerNight * selectedNbPersonnes;

    for (var option in optionPayanteChecks) {
      if (option.checked) {
        totalPrice += option.prix;
      }
    }

    return totalPrice;
  }

  _loadOptionPayantes() {
    optionPayanteChecks = widget.habitation.optionspayantes
        .map((option) =>
        OptionPayanteCheck(option.id, option.libelle, false,
            description: option.description, prix: option.prix))
        .toList();
  }

  _buildResume() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.white,
        leading: const Icon(Icons.home),
        title: Text(widget.habitation.libelle),
        subtitle: Text(widget.habitation.adresse),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  _buildDates() {
    return Center(
      child: GestureDetector(
        onTap: () => dateTimeRangePicker(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 8.0),
                Text(
                  '${_formatDate(dateDebut)}',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.blueAccent,
                ),
                const SizedBox(width: 8.0),
                Text(
                  _formatDate(dateFin),
                  style: const TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy', 'fr_FR').format(date);
  }

  dateTimeRangePicker() async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime
          .now()
          .year),
      lastDate: DateTime(DateTime
          .now()
          .year + 2),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale('fr', 'FR'),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
      });
    }
  }

  _buildNbPersonnes() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Text('Nombre de personnes'),
          const SizedBox(width: 10),
          DropdownButton<int>(
            value: selectedNbPersonnes,
            onChanged: (value) {
              print('Selected Number of Persons: $value');
              if (value != null) {
                setState(() {
                  selectedNbPersonnes = value;
                });
              }
            },
            items: nbPersonnesList.map((int nbPersonnes) {
              return DropdownMenuItem<int>(
                value: nbPersonnes,
                child: Text('$nbPersonnes'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  _buildOptionsPayantes(BuildContext context) {
    return Column(
      children: optionPayanteChecks
          .map((option) =>
          CheckboxListTile(
            title: Text(option.libelle),
            subtitle: Text(option.description),
            value: option.checked,
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  option.checked = value;
                });
              }
            },
            secondary: Text(format.format(option.prix)),
          ))
          .toList(),
    );
  }

  _buildRentButton() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
               //
              },
              child: Text(
                'Louer',
                style: TextStyle(
                  color: Colors.white, // white text color
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TotalWidget extends StatelessWidget {
  final double prixTotal;

  TotalWidget({required this.prixTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.blueAccent, width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'TOTAL',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          Text(
            '${prixTotal.toStringAsFixed(2)} €',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

// Supposons que cette fonction vérifie si l'utilisateur est connecté
bool isLoggedIn() {
  // Implémentez votre propre logique pour vérifier la connexion de l'utilisateur
  return false; // Par exemple, retourne false si l'utilisateur n'est pas connecté
}
