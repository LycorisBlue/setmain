import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'widgets/login.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await _initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 113, 0, 226),
        ),
      ),
      home: SplashView(),
    );
  }
}


class SplashView extends StatelessWidget {
  const SplashView({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 5), (){
        Get.offAll(SplashView2(), transition: Transition.zoom);
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: const Center(
        child: Text(
          'BASSIA TAXI',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
class SplashView2 extends StatelessWidget {
  const SplashView2({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // Timer(
    //   const Duration(seconds: 3), (){
    //     Get.offAll(LoginView(), transition: Transition.zoom);
    // });
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network("https://lottie.host/f362c057-3835-4478-a93c-2e926edfed63/GfSvlP2beI.json"),
              SizedBox(height: 20), // Espacement entre l'animation et le texte
              Text(
                'Etre serein ...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Get.offAll(Login(), transition: Transition.zoom,duration: Duration(milliseconds: 700));
        },
        label: Icon(Icons.arrow_forward),
        tooltip: 'Avancer', // Info-bulle lorsque vous maintenez enfoncé le bouton
       ),
    );
  }
}


Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox("login");
  await Hive.openBox("driver");
  await Hive.openBox("user");
}
