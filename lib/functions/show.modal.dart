import 'package:setmain/functions/post.function.dart';
import 'package:setmain/utils/QR.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showModalFriends(BuildContext context) {
  TextEditingController _controllerNumber = TextEditingController();
  TextEditingController _controllerLocalisation = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Partager"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controllerNumber,
              decoration: InputDecoration(
                focusColor: Colors.purpleAccent,
                hintText: "Son numéro",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllerLocalisation,
              decoration: InputDecoration(
                focusColor: Colors.purpleAccent,
                hintText: "La localisation",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le modal
            },
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              postTarget(receiver: _controllerNumber.text, body: _controllerLocalisation.text, context: context);
            },
            child: const Text("Valider"),
          ),
        ],
      );
    },
  );
}

void showModalDriver(BuildContext context) {
  TextEditingController textEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Partager"),
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            focusColor: Colors.purpleAccent,
            hintText: "ENTRER...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.purple)
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le modal
            },
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              String inputText = textEditingController.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BarcodeGeneratorApp(startingData: inputText)
                    ),
              );
            },
            child: const Text("Valider"),
          ),
        ],
      );
    },
  );
}


void showModalPosition(BuildContext context, double lat, double long) {
  TextEditingController textEditingController = TextEditingController();
  String url = "($lat), ($long)"; // Affiche les valeurs de lat et long dans le champ de texte
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Ma position"),
        content: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            focusColor: Colors.purpleAccent,
            hintText: "Son numero...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.purple),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le modal
            },
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              postTarget(receiver: textEditingController.text, body: url, context: context); // Affiche les valeurs dans la console
              Navigator.pop(context); // Ferme le modal
            },
            child: const Text("Valider"),
          ),
        ],
      );
    },
  );
}


