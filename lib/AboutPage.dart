import 'package:flutter/material.dart';
import 'package:stad_project/services/email_and_call.dart';

class AboutPage extends StatelessWidget {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  final String number = "98765432";
  final String email = "transporttravelgo@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.fromLTRB(20, 70, 20, 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'About Us',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 42,
                      color: Colors.indigo),
                ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'We are the cab service operators that will serve you 24/7, all you need to do is call us, and we will be there!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green[100],
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 42,
                      color: Colors.indigo),
                ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'For more enquiries: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: new InkWell(
                        child: new Text(
                          'Email Us: $email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.indigo),
                        ),
                        onTap: () => _service.sendEmail(email),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(40, 0, 20, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: new InkWell(
                        child: new Text(
                          'Call Us: $number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.indigo),
                        ),
                        onTap: () => _service.call(number),
                      ),
                    )),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.green[100],
            ),
          ),
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
  }
}
