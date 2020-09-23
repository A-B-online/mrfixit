import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrfixit/Constant/constant.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(LOADING_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
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
                children: <Widget>[],
              ),
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
                  Image.asset(
                    'images/fixlogo.png',
                    width: animation.value * 120,
                    height: animation.value * 120,
                  ),
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
                height: 70.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
