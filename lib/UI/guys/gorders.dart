import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders extends StatefulWidget {
  final String uid;
  final String service;
  Orders(this.uid, this.service);

  @override
  State<StatefulWidget> createState() => new OrdersState();
}

class OrdersState extends State<Orders> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
              child: AppBar(
          //backgroundColor: Colors.deepOrangeAccent,
          title: Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Text(
              widget.service,
              style: TextStyle(color: Colors.white),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(0.0),
          alignment: Alignment.center,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'ORDERS',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                    child: new StreamBuilder(
                        stream: Firestore.instance
                            .collection('MRFIXITJOBS').where('jobtype', isEqualTo: widget.service.toString())
                            .orderBy('jobtimestamp', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              padding: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, bottom: 5.0),
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white10),
                                    child: Column(
                                      children: <Widget>[
                                        //Divider(height: 5.0),
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          title: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, top: 10.0),
                                                    child: Text(
                                                        snapshot.data.documents[
                                                            index]['jobtype'],
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            color: Colors.black,
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
                                                      padding: const EdgeInsets.only(
                                                          left: 15.0, top: 10.0),
                                                      child: Text(
                                                          snapshot.data.documents[index]
                                                              ['jobdetails'],
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0,
                                                                top: 10.0),
                                                        child: Center(
                                                          child: Text(
                                                              snapshot.data
                                                                          .documents[
                                                                      index]
                                                                  ['jobstatus'],
                                                              style: TextStyle(
                                                                  color: snapshot.data.documents[index]['jobstatus'] ==
                                                                              "Pending"
                                                                          ? Colors
                                                                              .redAccent
                                                                          : Colors
                                                                              .greenAccent,
                                                                  fontSize:
                                                                      15.0,
                                                                      fontStyle: FontStyle.italic,
                                                                      fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                        )),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                           onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext bc) {
                                                return Container(
                                                   decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(40),
                                                      topRight:
                                                          Radius.circular(40),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ListView(
                                                      padding:
                                                        const EdgeInsets.all(2),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            SizedBox(height:15),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Text(
                                                                    snapshot.data
                                                                                .documents[
                                                                            index]
                                                                        ['jobtype'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                
                                                              ],
                                                            ),
                                                            SizedBox(height:15),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "STATUS : ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight.bold)),
                                                                Text(
                                                                    snapshot.data
                                                                                .documents[
                                                                            index][
                                                                        'jobstatus'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                        color: snapshot.data.documents[index]['jobstatus'] ==
                                                                                "Pending"
                                                                            ? Colors
                                                                                .redAccent
                                                                            : Colors
                                                                                .greenAccent,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10),
                                                            Row(
                                                              children: <Widget>[
                                                                Expanded(
                                                                  child: Text("DETAILS : " +
                                                                      snapshot.data
                                                                                  .documents[
                                                                              index]
                                                                          [
                                                                          'jobdetails'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20.0)),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20),
                                                            Row(
                                                              children: <Widget>[
                                                                Expanded(
                                                                  child: Text("NAME : " +
                                                                      snapshot.data
                                                                                  .documents[
                                                                              index]
                                                                          ['name'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20.0)),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10),
                                                            Row(
                                                              children: <Widget>[
                                                                Expanded(
                                                                  child: Text("CONTACT : " +
                                                                      snapshot.data
                                                                                  .documents[
                                                                              index]
                                                                          [
                                                                          'contact'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20.0)),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10),
                                                            Row(
                                                              children: <Widget>[
                                                                Expanded(
                                                                  child: Text("ADDRESS : " +
                                                                      snapshot.data
                                                                                  .documents[
                                                                              index]
                                                                          [
                                                                          'address'],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20.0)),
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
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                )
              ],
            ),
          )),
    );
  }


}
