import 'package:flutter/material.dart';
import 'package:stad_project/services/authenication.dart';
import 'HomePage.dart';
import 'AboutPage.dart';
import 'ProfilePage.dart';
import 'RegistrationPage.dart';
import 'sign_in.dart';
import 'package:provider/provider.dart';
import 'package:stad_project/models/user.dart';
import 'package:stad_project/services/email_and_call.dart';

void main() {
  setupLocator();
  runApp(Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Project(),
      ),
    );
  }
}

class Project extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return MyApp();
    }
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}

class MyApp extends StatelessWidget {
  final AuthService _auth = AuthService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "HOME",
                ),
                Tab(
                  text: "PROFILE",
                ),
                Tab(
                  text: "ABOUT",
                ),
              ],
            ),
            title: Text('TransportTravelGO')),
        body: Container(
          child: TabBarView(
            //Tab Bar to navigate to these 3 pages
            children: [HomePage(), ProfilePage(), AboutPage()],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.9), BlendMode.dstATop),
                image: AssetImage("images/taxi.png"),
                fit: BoxFit.cover),
            border: Border.all(
              color: Colors.brown,
              width: 4,
            ),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}

class Register extends StatelessWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegistrationPage(toggleView: toggleView));
  }
}

class Login extends StatelessWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignIn(toggleView: toggleView));
  }
}
