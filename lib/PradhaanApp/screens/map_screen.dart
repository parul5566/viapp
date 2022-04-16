/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  static final LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {

  };
  LatLng _currentMapPosition = _center;

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_currentMapPosition.toString()),
        position: _currentMapPosition,
        infoWindow: InfoWindow(
            title: 'Nice Place',
            snippet: 'Welcome to Poland'
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
                markers: _markers,
                onCameraMove: _onCameraMove
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: _onAddMarkerButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*//*

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsSample extends StatefulWidget {
  @override
  _MapsSampleState createState() => _MapsSampleState();
}

class _MapsSampleState extends State<MapsSample> {

  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(26.8206, 30.8025));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('serach'),
        centerTitle: true,
      ),
      drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _drawer(){
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("xyz"),
            accountEmail: Text("xyz@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("xyz"),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("abc"),
              )
            ],
          ),
          ListTile(
            title: new Text("Places"),
            leading: new Icon(Icons.location_on),
          ),
          Divider(),
          ListTile(
            onTap: (){
              _goToNewYork();
              Navigator.of(context).pop();
            },
            title: new Text("New York"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToNewDelhi();
              Navigator.of(context).pop();
            },
            title: new Text("New Delhi"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToLondon();
              Navigator.of(context).pop();
            },
            title: new Text("London"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToTokyo();
              Navigator.of(context).pop();
            },
            title: new Text("Tokyo"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToDubai();
              Navigator.of(context).pop();
            },
            title: new Text("Dubai"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToParis();
              Navigator.of(context).pop();
            },
            title: new Text("Paris"),
            trailing: new Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }


  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('newyork'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'New York', snippet: 'Welcome to New York')
        ),
      );
    });
  }

  Future<void> _goToNewDelhi() async {
    double lat = 28.644800;
    double long = 77.216721;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('newdelhi'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'New Delhi',  snippet: 'Welcome to New Delhi')),
      );
    });
  }

  Future<void> _goToLondon() async {
    double lat = 51.5074;
    double long = -0.1278;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('london'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'London',  snippet: 'Welcome to London')),
      );
    });
  }

  Future<void> _goToTokyo() async {
    double lat = 35.6795;
    double long = 139.77171;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('tokyo'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Tokyo',  snippet: 'Welcome to Tokyo')),
      );
    });
  }

  Future<void> _goToDubai() async {
    double lat = 25.2048;
    double long =55.2708;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('dubai'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Dubai',  snippet: 'Welcome to Dubai')),
      );
    });
  }

  Future<void> _goToParis() async {
    double lat = 48.8566;
    double long = 2.3522;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('paris'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Paris',  snippet: 'Welcome to Paris')),
      );
    });
  }
}*/
import 'package:flutter/material.dart';
import 'package:viapp/PradhaanApp/screens/contacts.dart';
import 'package:viapp/PradhaanApp/screens/main_screen.dart';
import 'package:viapp/PradhaanApp/screens/notifi_cation.dart';

class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  int _currentIndex = 0;
  List _screens = [
    HomePage(),
    ComplaintList(),
    NotificationPage(),
    /*  MapsSample(),*/
    /*ComplaintPage(),
    SuccessPage(),*/
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: Colors.green[700],
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Submit",
            icon: Icon(Icons.join_left_rounded),
          ),
          BottomNavigationBarItem(
            label: "Track",
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: "NotificationPage",
            icon: Icon(Icons.notifications),
          ),
          /* BottomNavigationBarItem(
            label: "Map",
            icon: Icon(Icons.location_on),
          ),*/

        ],
      ),
      body: _screens[_currentIndex],

    );
  }
}