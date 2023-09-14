import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/anwser.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

final Box _boxUser = Hive.box("user");

class MainProfil extends StatelessWidget {
  const MainProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 245, 255),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 90),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg'),
                ),
                const SizedBox(height: 20),
                itemProfile('Nom', _boxUser.get('name'), CupertinoIcons.person),
                const SizedBox(height: 20,),
                itemProfile('Prenom', _boxUser.get('lastname'), CupertinoIcons.person),
                const SizedBox(height: 20,),
                itemProfile('Numero', _boxUser.get('numero'), CupertinoIcons.phone),
                const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: Color.fromARGB(255, 113, 0, 226),
                      ),
                      child: const Text('Edit Profile')
                  ),
                ),
              ],
            ),
            Positioned(
              top: 20,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.settings),  // Icône des paramètres
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new onBordingScreen()));
                  print("L'icône des paramètres a été cliquée !");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepPurpleAccent.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
