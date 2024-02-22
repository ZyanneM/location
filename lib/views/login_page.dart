import 'package:flutter/material.dart';

class Account {
  String? password; // Ajoutez d'autres propriétés au besoin
}

class LoginPageArgument {
  final String routeNameNext;

  LoginPageArgument(this.routeNameNext);
}

class LoginPage extends StatefulWidget {
  static String routeName = 'login';
  final String routeNameNext;

  const LoginPage(this.routeNameNext, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  var account = Account(); // Instance de la classe Account

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          Image.asset('assets/images/locations/location.png'),
          const SizedBox(height: 30.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrez un mot de passe';
                    }
                    return null;
                  },
                  maxLines: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (value) => setState(() => account.password = value!), // Utilisation de l'instance de Account
                ),
                CheckboxListTile(
                  title: const Text("Se souvenir de moi"),
                  contentPadding: EdgeInsets.zero,
                  value: rememberValue,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (newValue) {
                    setState(() {
                      rememberValue = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _logUser(context);
                    }
                  },
                  child: const Text('Valider'),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pas enregistré ?'),
                    TextButton(
                      onPressed: () {
                      },
                      child: const Text('Créer un compte'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _logUser(BuildContext context) {
    // TODO : Faire la connexion de l'utilisateur
    print('_logUser: $account');
    // Affichage de la page et vidage de la pile des pages (sauf la première page : home)
    Navigator.pushNamedAndRemoveUntil(
        context, widget.routeNameNext, (route) => route.isFirst);
  }
}