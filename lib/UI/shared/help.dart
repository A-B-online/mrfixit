import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  //StateModel appState;
  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    //appState = StateWidget.of(context).state;
    return Scaffold(
        
        body: Container(
            margin: EdgeInsets.all(0.0),
            alignment: Alignment.center,
            child: Center(
              child: Text('HELP DOC'),
             )),
        );
  }

}
