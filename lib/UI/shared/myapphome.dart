import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mrfixit/UI/shared/connect.dart';
import 'package:mrfixit/UI/user/home.dart';
import 'package:mrfixit/UI/shared/profile.dart';
import 'package:mrfixit/UI/user/history.dart';
import 'package:mrfixit/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  int selectedIndex = 0;
  final widgetOptions = [
    Home(),
    //AdminHome(),
    //GuyHome(),
    HomeScreen(),
    ProfileScreen(),
    //HelpScreen(),
  ];

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          backgroundColor: Colors.indigo,
          title: Wrap(children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Mr Fixit',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ]),
          ]),
          actions: <Widget>[
            IconButton(
              icon: new Icon(
                Icons.exit_to_app,
                color: Colors.lightBlue,
                size: 25.0,
              ),
              onPressed: () => _signOut(context),
            ),
          ],
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.indigo,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.indigoAccent,
        height: 50,

        //type: BottomNavigationBarType.fixed,
        items: <Widget>[
          Icon(Icons.home),
          // Icon(Icons.home),
          Icon(Icons.assignment),
          Icon(Icons.account_circle),
          // Icon(Icons.help),
        ],
        onTap: onItemTapped,
      ),
    );
  }
}
