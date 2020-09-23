import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesName {

  final String id;
  final String name;
  final String imageurl;
  final int sid;

  ServicesName({this.id, this.name, this.sid, this.imageurl });

  factory ServicesName.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return ServicesName(
      id: doc.documentID,
      name: data['NAME'] ?? '',
      sid: data['SID'] ?? 100,
      imageurl: data['IMAGEURL'] ?? 'fixlogo.png',
    );
  }

}