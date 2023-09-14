import 'package:setmain/widgets/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyAppScan());
}

class MyAppScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR/Bar Code Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SCAN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  void _redirectToGoogleMaps(String url) async {
    final String googleMapsUrl = url; // URL de Google Maps avec le numéro de téléphone

    if (await canLaunch(googleMapsUrl)) {
       await launch(googleMapsUrl);
     } else {
       throw "Impossible d'ouvrir Google Maps";
    }
  }

  void _showResultModal(String qrResult) {
    List<String> qrParts = qrResult.split(
        ","); // Diviser la chaîne en utilisant la virgule comme séparateur

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("QR Code Result"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  title: Text("Nom"),
                  subtitle: Text(qrParts[0]),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Prénom"),
                  subtitle: Text(qrParts[1]),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Numéro"),
                  subtitle: Text(qrParts[2]),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Localisation"),
                  subtitle: Text(qrParts[3]),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme le modal
                _scanCode(); // Recommence le scan en rappelant la fonction _scanCode()
              },
              child: Text("Retry"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme le modal
                _redirectToGoogleMaps(qrParts[3]);
                // Ajoutez ici votre autre action pour le bouton "OK"
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
    });
    if (code != null) {
      _showResultModal(code);
    }
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: _camState
          ? Center(
              child: SizedBox(
                height: 500,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Text(_qrInfo!),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red, // Couleur de fond en rouge
        onPressed: () {
          Get.offAll(homePage(),
              transition: Transition.zoom,
              duration: Duration(milliseconds: 700));
        },
        label: Text("retour"),
      ),
    );
  }
}
