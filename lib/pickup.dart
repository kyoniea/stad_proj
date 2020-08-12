import 'package:flutter/material.dart';
import 'package:stad_project/journey.dart';
import 'package:stad_project/models/car.dart';
import 'package:stad_project/models/location.dart';

class PickUpPage extends StatelessWidget {
  final Car driverData;
  final Location locationData;
  PickUpPage({Key key, @required this.driverData, this.locationData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransportTravelGO'),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 10,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(20, 70, 20, 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Your Driver Is Coming!',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: "Trajan Pro",
                        fontSize: 32,
                        color: Colors.indigo),
                  ),
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Image.asset(
                'images/bluehead.png',
                height: 150,
                width: 150,
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(95, 20, 20, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Driver Name:     ' + driverData.driverName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(79, 0, 20, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Driver Contact:    ' + driverData.driverContact,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(83, 0, 20, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Plate Number:    ' + driverData.plateNo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(29, 0, 20, 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Number of car seats:     ' + driverData.seats,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(152, 0, 20, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    r'Price:    $12',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                )),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  child: Text('PICKED UP!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Journey(
                                  driverData: driverData,
                                  locationData: locationData,
                                )));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
