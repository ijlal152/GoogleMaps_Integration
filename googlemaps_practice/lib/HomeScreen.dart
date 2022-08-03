import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(33.5690628,72.6349776),
    zoom: 11, tilt: 60,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
      position: LatLng(33.5673,72.6506),
      infoWindow: InfoWindow(
        title: 'Fateh Jang'
      )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(33.5651,73.0169),
        infoWindow: InfoWindow(
            title: 'Rawalpindi'
        )
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(33.6938118,73.0651511),
        infoWindow: InfoWindow(
            title: 'Islamabad',
        )
    ),
  ];

  @override
  void initState(){
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(33.5673,72.6506),
                zoom: 14,
              ),
          ));
          setState((){

          });
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
