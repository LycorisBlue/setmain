import 'package:setmain/main.dart';
import 'package:setmain/widgets/home.view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:setmain/widgets/map.dart';
import 'dart:convert';

import '../widgets/login.dart';

final Box _boxLogin = Hive.box("login");
final Box _boxUser = Hive.box("user");
final Box _boxDriver = Hive.box("driver");
var url = 'http://192.168.1.77:3000';


Future<void> registerUser({
  required String name,
  required String lastName,
  required String number,
  required String password,
  required BuildContext context,
}) async {
  final apiUrl = '$url/users'; // Remplacez par l'URL de votre API

  final response = await http.post(
    Uri.parse(apiUrl),
    body: {
      'name': name,
      'lastname': lastName,
      'number': number,
      'password': password,
    },
  );

  if (response.statusCode == 201) {
    SnackbarUtils.showSuccessMessage(context, 'Enregistrement réussi');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Login()), // Remplacez Signup() par votre page d'inscription
    );
  } else {
    SnackbarUtils.showErrorMessage(context, 'Echec');
  }
}


Future<void> postTarget({
  required String receiver,
  required String body,
  required BuildContext context,
}) async {
  final apiUrl = '$url/targets'; // Remplacez par l'URL de votre API

  final response = await http.post(
    Uri.parse(apiUrl),
    body: {
      'sender': _boxUser.get('numero'),
      'receiver': receiver,
      'body': body,
      'stat': false.toString(),
    },
  );

  if (response.statusCode == 201) {
    SnackbarUtils.showSuccessMessage(context, 'Message envoyer avec succees');
    Navigator.of(context).pop(); // Ferme le modal
  }else if(response.statusCode == 404){
    SnackbarUtils.showErrorMessage(context, 'Veuillez verifier destinataire');
  }else {
    SnackbarUtils.showErrorMessage(context, 'Echec lors de la soumission');
  }
}




Future<void> registerDriver({
  required String email,
  required String marque,
  required String model,
  required String couleur,
  required String code,
  required String description,
  required BuildContext context,
}) async {
  final apiUrl = '$url/drivers'; // Remplacez par l'URL de votre API

  final response = await http.post(
    Uri.parse(apiUrl),
    body: {
      'user_number': _boxUser.get('numero'),
      'email': email,
      'marque': marque,
      'model': model,
      'couleur': couleur,
      'code': code,
      'description': description,
    },
  );

  if (response.statusCode == 201) {
    _boxLogin.put("loginDriverStatus", true);
    _boxDriver.put("email", email);
    _boxDriver.put("marque", marque);
    _boxDriver.put("model", model);
    _boxDriver.put("color", couleur);
    _boxDriver.put("code", code);
    _boxDriver.put("description", description);
    SnackbarUtils.showSuccessMessage(context, 'Enregistrement réussi');
    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new MyApp2()));
  } else if(response.statusCode == 404) {
    SnackbarUtils.showErrorMessage(context, "vous n'etes pas autoriser a acceder a ce menu");
    _boxLogin.clear();
    _boxUser.clear();
    _boxLogin.put('loginStatus', false);
    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new SplashView2()));
  }else{
    SnackbarUtils.showErrorMessage(context, "Une erreur est survenue veuillez ressayer ulterieurement");
  }
}


Future<void> authentificationUser({
  required String number,
  required String password,
  required BuildContext context,
}) async {
  final apiUrl = '$url/users/auth'; // Remplacez par l'URL de votre API

  final response = await http.post(
    Uri.parse(apiUrl),
    body: {
      'number': number,
      'password': password,
    },
  );
  
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    // final user = User.fromJson(jsonResponse);

    // Utilisez les variables de l'utilisateur récupérées
    _boxLogin.put("loginStatus", true);
    _boxUser.put("id", jsonData['id']);
    _boxUser.put("name", jsonData['name']);
    _boxUser.put("lastname", jsonData['lastname']);
    _boxUser.put("numero", jsonData['number']);
    _boxUser.put("password", jsonData['password']);

    SnackbarUtils.showSuccessMessage(context, 'Connexion réussie');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return homePage();
        },
      ),
    );
  } else {
    SnackbarUtils.showErrorMessage(context, 'Retry please');
  }
}

class SnackbarUtils {
  static void showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}