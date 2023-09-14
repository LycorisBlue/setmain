// ignore_for_file: prefer_const_constructors
import 'package:draggable_fab/draggable_fab.dart';
import 'package:setmain/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:setmain/widgets/profil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'box.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int selectedIndex = 0;

  final List<Widget> widgets = [
    MyApp2(),
    MyApp3(),
    MainProfil(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      floatingActionButton: DraggableFab(
        initPosition: Offset(1, MediaQuery.of(context).size.height / 3.5),
        child: FloatingActionButton(
          onPressed: () async {
            final String googleMapsUrl = 'geo:0,0?q=Google+Maps';

            if (await canLaunch(googleMapsUrl)) {
              await launch(googleMapsUrl);
            } else {
              throw 'Impossible d\'ouvrir Google Maps';
            }
          },
          backgroundColor: Colors.purple.shade400, // Couleur d'arrière-plan
          elevation: 6.0,
          child: Icon(Icons.location_on), // Hauteur du matériau élevé (ombre)
        ),
      ),
      body: widgets[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 113, 0, 226),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 7), // Ajustez cet offset pour déplacer l'ombre.
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
              gap: 15,
              backgroundColor: Color.fromARGB(255, 113, 0, 226),
              activeColor: Colors.white,
              tabBackgroundColor: Color.fromARGB(255, 167, 79, 255),
              padding: EdgeInsets.all(16),
              color: Colors.white,
              tabs: const [
                GButton(
                  icon: Icons.person_pin_circle_outlined,
                  text: 'Ma carte',
                ),
                GButton(
                  icon: Icons.message_outlined,
                  text: 'Mes messages',
                ),
                GButton(
                  icon: Icons.person_pin_outlined,
                  text: 'Mon profil',
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: onItemTapped,
            ),
        ),
      ),
    );
  }
}