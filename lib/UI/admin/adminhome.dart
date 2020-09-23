import 'package:flutter/material.dart';
import 'package:mrfixit/UI/admin/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrfixit/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 8 * 7,
            width: MediaQuery.of(context).size.width,
            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('SERVICES').where("DISPLAY", isEqualTo: "1")
                    .orderBy('SID', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, bottom: 5.0),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => _orders(
                              context, snapshot.data.documents[index]['NAME']),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                    pic(
                            snapshot.data.documents[index]["IMAGEURL"]),
                                    Text(
                                      snapshot.data.documents[index]['NAME'],
                                      softWrap: false,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ])),
                              color: Colors.white,
                              margin: EdgeInsets.all(1.0),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ]));
  }

  Widget pic(String img) {
    return Image.network(
      img,
      fit: BoxFit.fill,
      height: 40,
      width: 40,
    );
  }

  void _orders(BuildContext context, String service) async {
    final user =
        Provider.of<User>(context, listen: false);
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Orders(
              user.uid,
              service)),
    );
  }
}
