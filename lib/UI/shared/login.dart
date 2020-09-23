import 'package:flutter/material.dart';
import 'package:mrfixit/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Image.asset('images/fixit.png',
                        width: 300.0, height: 75.0, fit: BoxFit.fill),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Prompt services at your Doorstep",
                    style: TextStyle(
                        color: Colors.blueAccent[100],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/plumber.png',
                      width: 75.0, height: 75.0, fit: BoxFit.fill),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Image.asset('images/electr.png',
                      width: 75.0, height: 75.0, fit: BoxFit.fill),
                  Spacer(flex: 3),
                  Image.asset('images/ac.png',
                      width: 75.0, height: 75.0, fit: BoxFit.fill),
                  Spacer(flex: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/home.jpg',
                      width: 120.0, height: 120.0, fit: BoxFit.fill),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 1),
                  Image.asset('images/paint.png',
                      width: 75.0, height: 75.0, fit: BoxFit.fill),
                  Spacer(flex: 3),
                  Image.asset('images/mashan.png',
                      width: 75.0, height: 75.0, fit: BoxFit.fill),
                  Spacer(flex: 1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/macnic.png',
                      width: 75.0, height: 75.0, fit: BoxFit.fill),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                  onPressed: () => _signInWithGoogle(context),
                  padding: EdgeInsets.only(
                      top: 3.0, bottom: 3.0, left: 5.0, right: 5.0),
                  color: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'images/google_icon.png',
                        height: 40.0,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
