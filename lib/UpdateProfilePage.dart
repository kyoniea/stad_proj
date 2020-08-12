import 'package:flutter/material.dart';
import 'package:stad_project/models/user.dart';
import 'package:stad_project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:stad_project/loading.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String contact;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.9), BlendMode.dstATop),
                image: AssetImage("images/taxi.png"),
                fit: BoxFit.cover),
            border: Border.all(
              color: Colors.green,
              width: 10,
            ),
          ),
          height: 605,
          child: StreamBuilder<UserData>(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData userData = snapshot.data;
                  return Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Update Profile',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 42,
                                    color: Colors.indigo,
                                  ),
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  initialValue: userData.name,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white70,
                                    hintText: "Enter Name",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.blue),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                  ),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter a name' : null,
                                  onChanged: (val) {
                                    setState(() => name = val);
                                  },
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  initialValue: userData.contact,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white70,
                                    hintText: "Enter Contact",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.blue),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                  ),
                                  validator: (val) =>
                                      val.length < 8 || val.isEmpty
                                          ? 'Enter a contact that has 8 numbers'
                                          : null,
                                  onChanged: (val) {
                                    setState(() => contact = val);
                                  },
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  color: Colors.cyan,
                                  elevation: 5,
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await DatabaseService(uid: user.uid)
                                          .updateUserData(
                                              userData.email,
                                              name ?? userData.name,
                                              contact ?? userData.contact);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Profile Updated!"),
                                            content: Text(
                                                "Successfully updated profile!"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Okay"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              )),
                        ],
                      ),
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
              }),
        ),
      ),
    );
  }
}
