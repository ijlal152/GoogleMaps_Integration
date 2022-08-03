import 'package:flutter/material.dart';
import 'package:googlemaps_practice/ConvertLatLngToAddress.dart';
import 'package:googlemaps_practice/HomeScreen.dart';
import 'package:googlemaps_practice/current_location.dart';
import 'package:googlemaps_practice/google_places_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrentLocation(),
    );
  }
}
