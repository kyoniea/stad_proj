import 'package:flutter/material.dart';
import 'services/authenication.dart';
import 'package:stad_project/loading.dart';

class RegistrationPage extends StatefulWidget {
  final Function toggleView;
  RegistrationPage({this.toggleView});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String contact = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Registration'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  height: 605,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: AssetImage("images/register_background.jpg"),
                        fit: BoxFit.cover),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(35, 20, 20, 10),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 42,
                                    color: Colors.white),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.indigo),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  hintText: "Enter name",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.indigo),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
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
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  hintText: "Enter Contact",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.indigo),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
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
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.indigo),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                obscureText: true,
                                validator: (val) => val.isEmpty ||
                                        val.length < 6
                                    ? 'Enter a password that has at least 6 characters'
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(20, 35, 20, 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: RaisedButton(
                                color: Colors.green,
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.register(
                                        email, password, name, contact);
                                    if (result == null) {
                                      setState(() {
                                        error = 'Please provide a valid email';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            )),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  )),
            ));
  }
}
