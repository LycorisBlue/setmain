import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:setmain/functions/show.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:setmain/utils/SCAN.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GeolocatorApp(),
    );
  }
}

class GeolocatorApp extends StatefulWidget {
  const GeolocatorApp({Key? key}) : super(key: key);

  @override
  _GeolocatorAppState createState() => _GeolocatorAppState();
}

class _GeolocatorAppState extends State<GeolocatorApp> {
  Position? _currentLocation;
  List<LatLng> routpoints = [LatLng(52.05884, -1.345583)];
  final Box _boxLogin = Hive.box("login");
  
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _getCurrentLocation();
    });
  }

  Future<void> _getCurrentLocation() async {
    bool servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print('Service de localisation désactivé');
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _boxLogin.get("loginDriverStatus") ?? false
          ? FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 144, 33, 255),
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppScan()));
        },
        child: Icon(Icons.qr_code),
      )
          : SpeedDial(
        backgroundColor: Color.fromARGB(255, 144, 33, 255),
        activeBackgroundColor: Color.fromARGB(255, 167, 79, 255),
        animatedIcon: AnimatedIcons.list_view,
        spaceBetweenChildren: 16,
        children: [
          SpeedDialChild(
            child: Icon(Icons.car_crash_sharp),
            label: 'Chauffeur',
            backgroundColor: Color.fromARGB(255, 144, 33, 255),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onTap: () {
              showModalDriver(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.person_add_alt_1),
            label: 'Amis',
            backgroundColor: Color.fromARGB(255, 144, 33, 255),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onTap: () {
              showModalFriends(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.my_location),
            label: 'Ma position',
            backgroundColor: Color.fromARGB(255, 144, 33, 255),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onTap: (){
              showModalPosition(context, _currentLocation!.latitude, _currentLocation!.longitude);
            } ,
          ),
        ],
      ),

      body: _currentLocation != null
          ? SafeArea(
              child: Expanded(
                child: SizedBox(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(_currentLocation!.latitude,
                          _currentLocation!.longitude),
                      zoom: 17,
                    ),
                    // nonRotatedChildren: [
                    //   AttributionWidget.defaultWidget(
                    //     source: 'OpenStreetMap contributors',
                    //     onSourceTapped: null,
                    //   ),
                    // ],
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(_currentLocation!.latitude,
                                _currentLocation!.longitude),
                            width: 30,
                            height: 30,
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      PolylineLayer(
                        polylineCulling: false,
                        polylines: [
                          Polyline(
                            points: routpoints,
                            color: Colors.blue,
                            strokeWidth: 9,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
