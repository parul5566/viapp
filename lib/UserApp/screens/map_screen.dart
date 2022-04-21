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


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viapp/UserApp/const/AppColors.dart';
import 'package:viapp/UserApp/ui/auth_controller.dart';
import 'package:viapp/UserApp/ui/login_screen.dart';


class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  double value  = 0;
  final PrefService _prefService = PrefService();


  navigateLogin() async {
    Navigator.pushReplacementNamed(context, "login");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     /*   actions: [IconButton(onPressed: () async {
          await _prefService.removeCache("password").whenComplete(() {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>
                        LoginScreen()));
          });


        }, icon: Icon(Icons.logout))],*/

        automaticallyImplyLeading: false,
        title: Center(
          child: Row(
            children: [
              Image.asset('assets/icon.png',width: 30),
              Text('Gramin Complaint App'),
            ],
          ),
        ),
      ),








    drawer:  Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: AppColors.deep_orange,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/img/worker.png'),
                      ),
                    ),
                  ),
                 /* _auth.currentUser != null
                      ? Text(
                    _auth.currentUser.email,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Righteous'),
                  )*/
                      : Text('email'),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () async {
              await _auth.signOut().then((value) => navigateLogin());
            },
          )
        ],
      ),
    ),



      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset('assets/icon.png',width: 200),
              SizedBox(height: 20),
              Text(("Submit your Complaint")),
              SizedBox(height: 20),
              Text(("At Gramin app , you can complaint to any query to help")),
              SizedBox(height: 20),
              Container(
                width: 150,
                child: new SizedBox(
                  width: 200.0,
                  child:/* ElevatedButton(
                    child: Text('GET STARTED'),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Contacts()),
                      );
                    },
                  )*/
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Contacts()),
                      );


                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: (isLoading)
                        ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ))
                        : const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void downloadData(){
    new Timer.periodic(
        Duration(seconds: 1),
            (Timer timer){
          setState(() {
            if(value == 1) {
              timer.cancel();
            }
            else {
              value = value + 0.1;
            }
          });
        }
    );
  }
}



