
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:search_map_place/search_map_place.dart';
const kGoogleApiKey = "AIzaSyC2Ed8NK3U_TNsH74XBu7SUcu89yIw-WhU";


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  String searchAddr;

  @override
   initState()  {
    super.initState();
      requestPermission();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> requestPermission() async {
    await Permission.location.request();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body:Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
     Positioned(
       top:30,
       left:10,
       right:10,
       child: SearchMapPlaceWidget(
         placeholder: "search",
         placeType:PlaceType.address,
         apiKey: "AIzaSyC2Ed8NK3U_TNsH74XBu7SUcu89yIw-WhU",
         onSelected: (Place place) async {
           Geolocation geolocation = await place.geolocation;
           mapController.animateCamera(CameraUpdate.newLatLng(
             geolocation.coordinates
           ));
           mapController.animateCamera(
             CameraUpdate.newLatLngBounds(geolocation.bounds,0)
           );
         },
       ),
     )
        ],
      ),
    );
  }
}
