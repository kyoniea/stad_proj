import "package:flutter/material.dart";
import 'services/authenication.dart';
import 'package:stad_project/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Sign in"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
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
                      image: AssetImage("images/signin_background.jpg"),
                      fit: BoxFit.cover),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        'images/taxidriver.png',
                        height: 120,
                        width: 120,
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 42,
                                  color: Colors.white),
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
                                hintText: "Enter Email",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
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
                                hintText: "Enter Password",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
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
                              obscureText: true,
                              validator: (val) => val.isEmpty || val.length < 6
                                  ? 'Enter a password that has at least 6 characters'
                                  : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                          )),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Login failed: Your email or password is incorrect.';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
