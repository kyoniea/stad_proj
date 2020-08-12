import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stad_project/models/car.dart';
import 'package:stad_project/models/location.dart';
import 'package:stad_project/pickup.dart';

class Maps extends StatefulWidget {
  final double lat;
  final double lng;

  Maps({Key key, @required this.lat, this.lng}) : super(key: key);

  @override
  _MapsState createState() => _MapsState(currentlat: lat, currentlng: lng);
}

class _MapsState extends State<Maps> {
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;

  String dropdownValue = '2 Seats';

  List<String> spinnerItems = [
    '2 Seats',
    '4 Seats',
    '6 Seats',
  ];

  final double currentlat;
  final double currentlng;
  String searchAddr;
  double searchlat;
  double searchlng;
  //Car car;

  _MapsState({Key key, @required this.currentlat, this.currentlng});

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(currentlat, currentlng),
          infoWindow: InfoWindow(
            title: "Your Location",
          ),
        ),
      );
    });
  }

  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      _mapController.animateCamera(CameraUpdate.newLatLng(
        LatLng(result[0].position.latitude, result[0].position.longitude),
      ));
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(
                result[0].position.latitude, result[0].position.longitude),
            infoWindow: InfoWindow(
              title: "Your Destination",
            ),
          ),
        );
      });
      setState(() => searchlat = result[0].position.latitude);
      setState(() => searchlng = result[0].position.longitude);
    });
  }

  Future getCar() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("cars").getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick Your Location'),
          backgroundColor: Colors.green,
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(currentlat, currentlng),
              zoom: 15,
            ),
            markers: _markers,
          ),
          Positioned(
            top: 20.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Destination',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchandNavigate();
                        setState(() {
                          _markers.remove(_markers.firstWhere(
                              (Marker marker) => marker.markerId.value == "1"));
                        });
                      },
                      iconSize: 30.0,
                    )),
                onChanged: (val) {
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          ),
          Positioned(
            top: 545.0,
            right: 155.0,
            left: 15.0,
            child: Container(
              height: 40,
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  'BOOK NOW!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                color: Colors.green,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  if (searchAddr == null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "No Destination!",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                              ),
                            ),
                            content: Text('Please enter a destination.'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                              future: getCar(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text(
                                      "Looking for driver...\nPlease wait...",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.none),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        var alert;
                                        if (snapshot.data[index].data["seats"]
                                                .toString() ==
                                            dropdownValue) {
                                          alert = AlertDialog(
                                            title: Text(
                                              "Driver Found!",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.green,
                                              ),
                                            ),
                                            content: Text("Hi! My name is " +
                                                snapshot.data[index]
                                                    .data["driverName"]
                                                    .toString() +
                                                "!\nContact: " +
                                                snapshot.data[index]
                                                    .data["driverContact"]
                                                    .toString() +
                                                "\nCar Plate: " +
                                                snapshot
                                                    .data[index].data["plateNo"]
                                                    .toString() +
                                                "\nNumber of car seats: " +
                                                snapshot
                                                    .data[index].data["seats"]
                                                    .toString()),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  "Great!",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Location location =
                                                      new Location(
                                                          currentLatitude:
                                                              currentlat,
                                                          currentLongtitude:
                                                              currentlng,
                                                          destinationLatitude:
                                                              searchlat,
                                                          destinationLongtitude:
                                                              searchlng);
                                                  Car car = new Car(
                                                      driverName: snapshot
                                                          .data[index]
                                                          .data["driverName"]
                                                          .toString(),
                                                      driverContact: snapshot
                                                          .data[index]
                                                          .data["driverContact"]
                                                          .toString(),
                                                      plateNo: snapshot
                                                          .data[index]
                                                          .data["plateNo"]
                                                          .toString(),
                                                      seats: snapshot
                                                          .data[index]
                                                          .data["seats"]
                                                          .toString());
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PickUpPage(
                                                                driverData: car,
                                                                locationData:
                                                                    location,
                                                              )));
                                                },
                                              )
                                            ],
                                          );
                                        } else {
                                          alert = Center(
                                            child: Text(""),
                                          );
                                        }
                                        return alert;
                                      });
                                }
                              });
                        });
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 510.0,
            left: 15.0,
            child: Container(
              child: Text(
                'Number of seats required:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Positioned(
            top: 495.0,
            left: 235.0,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.red, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.green[500],
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                });
              },
              items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
        ]));
  }
}
