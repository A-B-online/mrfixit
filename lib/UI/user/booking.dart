import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:mrfixit/componets/job.dart';
import 'package:mrfixit/db/firebase.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Bookings extends StatefulWidget {
  final String uid;
  final Note note;
  final String service;
  Bookings(this.uid, this.note, this.service);

  @override
  State<StatefulWidget> createState() => new _BookingsState();
}

class _BookingsState extends State<Bookings> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  final formKey = new GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _buttonEnabled = true;

  //String _jobtype;

  TextEditingController _nameController;
  TextEditingController _addressController;
  TextEditingController _contactController;
  TextEditingController _jobdetailsController;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate) {
      print('Date selected: ${selectedDate.toString()}');
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      print('Time selected: ${selectedTime.toString()}');
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      buttondisable();
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        db
            .createNote(
                widget.uid,
                _nameController.text,
                _addressController.text,
                _contactController.text,
                "Pending",
                widget.service,
                _jobdetailsController.text,
                DateFormat.yMMMd().format(selectedDate),
                selectedTime.format(context),
                DateFormat.yMMMd().format(DateTime.now()).toString(),
                DateFormat.Hms().format(DateTime.now()).toString(),
                DateTime.now().toString())
            .then((_) {
          Navigator.pop(context);
          buttonenable();
        });
      } catch (e) {
        print('Error: $e');
        _key.currentState
            .showSnackBar(SnackBar(content: Text("Something is wrong")));
        buttonenable();
      }
    } else {
      _key.currentState
          .showSnackBar(SnackBar(content: Text("Please fill all details")));
      buttonenable();
    }
  }

  void buttonenable() {
    setState(() {
      _buttonEnabled = true;
    });
  }

  void buttondisable() {
    setState(() {
      _buttonEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.note.name);

    _addressController = TextEditingController(text: widget.note.address);

    _contactController = TextEditingController(text: widget.note.contact);

    _jobdetailsController = TextEditingController(text: widget.note.jobdetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
            //backgroundColor: Colors.deepOrangeAccent,
            title: Center(
              child: Text(
                widget.service,
                style: TextStyle(color: Colors.white),
              ),
            ),
            automaticallyImplyLeading: false),
      ),
      body: Container(
          margin: EdgeInsets.all(5.0),
          //alignment: Alignment.center,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  maxLines: 5,
                                  maxLengthEnforced: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: _jobdetailsController,
                                  decoration: InputDecoration(
                                    labelText: 'SERVICE DETAILS',
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Service Details can\'t be empty'
                                      : null,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  maxLines: null,
                                  maxLengthEnforced: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: 'NAME',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Name can\'t be empty'
                                      : null,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  maxLines: 3,
                                  maxLengthEnforced: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                    labelText: 'ADDRESS',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  validator: (value) => value.isEmpty
                                      ? 'Address can\'t be empty'
                                      : null,
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                  maxLines: null,
                                  maxLengthEnforced: false,
                                  keyboardType: TextInputType.multiline,
                                  controller: _contactController,
                                  decoration: InputDecoration(
                                    labelText: 'Contact Number',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  validator: (value) => value.length != 10
                                      ? ' Enter a Valid Mobile Number '
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.calendar_today,
                                              size: 30.0),
                                          color: Colors.indigo,
                                          onPressed: () {
                                            _selectDate(context);
                                          }),
                                      Text(
                                        '${DateFormat.yMMMd().format(selectedDate)}',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        width: 45.0,
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.watch_later,
                                              size: 30.0),
                                          color: Colors.indigo,
                                          onPressed: () =>
                                              _selectTime(context)),
                                      Text(
                                        '${selectedTime.format(context)}',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5.0, left: 3.0, right: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                top: 5.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                              child: RaisedButton(
                                            child: Text(
                                              "BOOK",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                            textColor: Colors.white,
                                            color: _buttonEnabled
                                                ? Colors.indigo
                                                : Colors.indigo[100],
                                            onPressed: _buttonEnabled
                                                ? () {
                                                    validateAndSubmit();
                                                  }
                                                : null,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          )),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                top: 5.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                              child: RaisedButton(
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                            textColor: Colors.white,
                                            color: Colors.indigo,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0)),
                                          )),
                                          flex: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //SizedBox(height: 20.0)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
