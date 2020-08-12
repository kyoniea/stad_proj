import 'package:flutter/material.dart';
import 'package:stad_project/models/user.dart';
import 'package:stad_project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:stad_project/loading.dart';
import 'UpdateProfilePage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 90,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 42,
                            color: Colors.indigo,
                          ),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Email: ' + userData.email,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Name: ' + userData.name,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Contact: ' + userData.contact,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )),
                          )
                        ]),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 5,
                          child: Text("Update Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                          color: Colors.cyan,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateProfile()));
                          },
                        ),
                      )),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                color: Colors.white70,
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
