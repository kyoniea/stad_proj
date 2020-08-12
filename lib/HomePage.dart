import 'package:flutter/material.dart';
import 'package:stad_project/Maps.dart';
import 'package:stad_project/models/user.dart';
import 'package:stad_project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:stad_project/loading.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double lat = 0.0;
  double lng = 0.0;

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      lat = position.latitude;
    });
    setState(() {
      lng = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'images/TransportTravelGo.png',
                        height: 350,
                        width: 350,
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Welcome " +
                            userData.name +
                            "! \n Click 'Book Now!' to start your journey!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    color: Colors.green[100],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 10,
                      child: Text('BOOK NOW!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                      color: Colors.green,
                      onPressed: () {
                        _getCurrentLocation();
                        if (lat == 0.0) {
                          print("Press Book Again");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Maps(lat: lat, lng: lng)));
                        }
                      },
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "You can find out more about us in the 'ABOUT' section above!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    )),
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
