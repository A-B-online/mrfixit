import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrfixit/Splash/splash_screen.dart';
import 'package:mrfixit/Constant/constant.dart';
import 'package:mrfixit/UI/shared/help.dart';
import 'package:mrfixit/UI/shared/loading.dart';
import 'package:mrfixit/UI/shared/myapphome.dart';
import 'package:mrfixit/UI/shared/profile.dart';
import '../user/history.dart';
import '../shared/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
          home: AnimatedSplashScreen(),
          title: 'Mr Fixit',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryIconTheme: IconThemeData(color: Colors.indigo),
              primaryColor: Colors.indigo,
              appBarTheme: AppBarTheme(
                color: Colors.indigo,
                iconTheme: IconThemeData(color: Colors.white),
              )),
          routes: <String, WidgetBuilder>{
            LOADING_SCREEN: (BuildContext context) => Loading(),
            SPLASH_SCREEN: (BuildContext context) => AnimatedSplashScreen(),
            HOME_SCREEN: (BuildContext context) => MyApp(),
            APPHOME_SCREEN: (BuildContext context) => MyAppHome(),
            MYBOOKING_SCREEN: (BuildContext context) => HomeScreen(),
            PROFILE_SCREEN: (BuildContext context) => ProfileScreen(),
            HELP_SCREEN: (BuildContext context) => HelpScreen(),
            LOGIN_SCREEN: (BuildContext context) => LoginScreen(),
          },
        );
  }
}
