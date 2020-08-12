import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:stad_project/main.dart';
import 'package:stad_project/models/car.dart';
import 'package:stad_project/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Journey extends StatefulWidget {
  final Car driverData;
  final Location locationData;

  Journey({Key key, @required this.driverData, this.locationData})
      : super(key: key);

  @override
  _JourneyState createState() =>
      _JourneyState(driver: driverData, location: locationData);
}

class _JourneyState extends State<Journey> {
  Set<Marker> _markers = HashSet<Marker>();

  final Car driver;
  final Location location;

  _JourneyState({Key key, @required this.driver, this.location});

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position:
              LatLng(location.currentLatitude, location.currentLongtitude),
          infoWindow: InfoWindow(
            title: "Your Location",
          ),
        ),
      );
    });

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(
              location.destinationLatitude, location.destinationLongtitude),
          infoWindow: InfoWindow(
            title: "Your Destination",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Trip'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(location.currentLatitude, location.currentLongtitude),
              zoom: 12,
            ),
            markers: _markers,
          ),
          Positioned(
            top: 455.5,
            left: 5.0,
            child: SizedBox(
              height: 130.0,
              width: 350.0,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 480.0,
            left: 40,
            child: Text(
              'Name:     ' + driver.driverName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 510.0,
            left: 46.5,
            child: Text(
              r'Price:      $12',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 555.0,
            left: 190.0,
            child: RaisedButton(
              child: Text("DROPPED OFF!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              color: Colors.green,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Trip Ended!",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.green,
                          ),
                        ),
                        content: Text(
                          'Thank You for using TransportTravelGO!\nWe hope you enjoyed your riding experience!\nDo remember to thank your driver before leaving!',
                          style: TextStyle(fontSize: 14),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Back to menu",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Start()));
                            },
                          )
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
