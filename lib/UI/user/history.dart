import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrfixit/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context, listen: false);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(0.0),
        alignment: Alignment.center,
        child: Center(
            child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
                          child: new StreamBuilder(
                              stream: Firestore.instance
                                  .collection('userdata')
                                  .document(user.uid.toString())
                                  .collection("jobdatap")
                                  .orderBy('jobtimestamp', descending: true)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                      child: CircularProgressIndicator());
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.documents.length,
                                    padding: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, bottom: 5.0),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 8.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 1.0),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white10),
                                              child: Column(
                                                children: <Widget>[
                                                  //Divider(height: 1.0),
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0,
                                                            vertical: 5.0),
                                                    title: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5.0,
                                                                      top:
                                                                          10.0),
                                                              child: Text(
                                                                  snapshot.data
                                                                              .documents[
                                                                          index]
                                                                      [
                                                                      'jobtype'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 15.0,
                                                                    top: 10.0),
                                                                child: Text(
                                                                    snapshot.data
                                                                            .documents[index]
                                                                        [
                                                                        'jobdetails'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        //enableDrag: true,
                                                        builder:
                                                            (BuildContext bc) {
                                                          return Stack(
                                                            children: <Widget>[
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            15),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            15),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      ListView(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(2),
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    children: <
                                                                        Widget>[
                                                                      Column(
                                                                        children: <
                                                                            Widget>[
                                                                          SizedBox(
                                                                              height: 20),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(snapshot.data.documents[index]['jobtype'], style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Text("DETAILS : " + snapshot.data.documents[index]['jobdetails'], overflow: TextOverflow.clip, style: TextStyle(color: Colors.black, fontSize: 20.0)),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 15),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Text("NAME : " + snapshot.data.documents[index]['name'], style: TextStyle(color: Colors.black, fontSize: 20.0)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Text("CONTACT : " + snapshot.data.documents[index]['contact'], style: TextStyle(color: Colors.black, fontSize: 20.0)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Text("ADDRESS : " + snapshot.data.documents[index]['address'], style: TextStyle(color: Colors.black, fontSize: 20.0)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: 20)
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                //top: 0,
                                                                //right: 0,
                                                                //width: 380,
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      1,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              4,
                                                                          horizontal:
                                                                              6),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: snapshot.data.documents[index]['jobstatus'] == "Pending"
                                                                              ? Colors.redAccent
                                                                              : Colors.greenAccent,
                                                                          borderRadius: BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(15),
                                                                            topLeft:
                                                                                Radius.circular(15),
                                                                          ) // green shaped
                                                                          ),
                                                                  child: Text(
                                                                      snapshot.data
                                                                              .documents[index]
                                                                          [
                                                                          'jobstatus'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .indigo,
                                                                          fontSize:
                                                                              15.0,
                                                                          fontStyle: FontStyle
                                                                              .italic,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 6),
                                                decoration: BoxDecoration(
                                                    color: snapshot.data.documents[
                                                                    index]
                                                                ['jobstatus'] ==
                                                            "Pending"
                                                        ? Colors.redAccent
                                                        : Colors.greenAccent,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ) // green shaped
                                                    ),
                                                child: Text(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['jobstatus'],
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 15.0,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ),
                    ],
                  )
                ),
      ),
    );
  }
}
