import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrfixit/UI/user/booking.dart';
import 'package:mrfixit/componets/job.dart';
import 'package:mrfixit/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    .collection('SERVICES')
                    .where("DISPLAY", isEqualTo: "1")
                    .orderBy('SID', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, bottom: 5.0),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => _createNewJob(
                              context, snapshot.data.documents[index]['NAME']),
                          child: Card(
                            elevation: 8.0,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                        pic(snapshot.data.documents[index]
                                            ['IMAGEURL']),
                                        Text(
                                          snapshot.data.documents[index]
                                              ['NAME'],
                                          softWrap: false,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          snapshot.data.documents[index]
                                              ['TIMETAG'],
                                          softWrap: false,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ])),
                                  color: Colors.white,
                                  margin: EdgeInsets.all(1.0),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 6),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        ) // green shaped
                                        ),
                                    child: snapshot.data.documents[index]
                                                ['NEW'] ==
                                            "1"
                                        ? Text("New",
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold))
                                        : Text(""),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
          //ServiceCards(),
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

  void _createNewJob(BuildContext context, String service) async {
    final user =
        Provider.of<User>(context, listen: false);
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Bookings(user.uid,
              Note(null, '', '', '', '', '', '', '', '', '', '', '', ''),
              service)),
    );
  }
}
