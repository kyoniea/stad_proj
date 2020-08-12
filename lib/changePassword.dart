import 'package:flutter/material.dart';
import 'services/authenication.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  String error = '';
  //bool checkCurrentPasswordValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          title: Text('Change Password'),
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
          child: Container(
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
                          'Change Password',
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
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Enter current password",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          validator: (val) => val.isEmpty
                              ? 'Enter your current password'
                              : null,
                          onChanged: (val) {
                            setState(() => currentPassword = val);
                          },
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Enter new password",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter a new password' : null,
                          onChanged: (val) {
                            setState(() => newPassword = val);
                          },
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Confirm password",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Confirm your new password' : null,
                          onChanged: (val) {
                            setState(() => confirmPassword = val);
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
                            "CHANGE PASSWORD",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Password Updated!"),
                                    content:
                                        Text("Password successfully changed!"),
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
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
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
          ),
        )));
  }
}
