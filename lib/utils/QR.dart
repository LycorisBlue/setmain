import 'package:setmain/widgets/home.view.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';



class BarcodeGeneratorApp extends StatefulWidget {
  final String startingData; // New parameter

  BarcodeGeneratorApp({required this.startingData}); // Constructor

  @override
  _BarcodeGeneratorAppState createState() => _BarcodeGeneratorAppState();
}

class _BarcodeGeneratorAppState extends State<BarcodeGeneratorApp> {
  final Box _boxUser = Hive.box("login");
  String barcodeData = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData(){


    setState(() {
      barcodeData =
          '$_boxUser.get("name"),$_boxUser.get("lastname"),$_boxUser.get("numero"),${widget.startingData}'; // Concatenate startingData as well
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: barcodeData,
                width: 280,
                height: 280,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () {
            Get.offAll(homePage(),
                transition: Transition.zoom,
                duration: Duration(milliseconds: 700));
          },
          label: Text("retour"),
        ),
      ),
    );
  }
}
