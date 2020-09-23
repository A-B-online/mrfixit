import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrfixit/componets/job.dart';
import 'package:mrfixit/componets/model.dart';

final CollectionReference noteCollection =
    Firestore.instance.collection('MRFIXITJOBS');

final CollectionReference noteCollectionp =
    Firestore.instance.collection('userdata');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<Note> createNote(
      String uid,
      String name,
      String address,
      String contact,
      String jobstatus,
      String jobtype,
      String jobdetails,
      String jobaskdate,
      String jobasktime,
      String jobdate,
      String jobtime,
      String jtimestamp) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(noteCollection.document());
      final DocumentSnapshot dsp = await tx.get(noteCollectionp
          .document(uid)
          .collection("jobdatap")
          .document(ds.documentID));

      final Note note = new Note(
          ds.documentID,
          uid,
          name,
          address,
          contact,
          jobstatus,
          jobtype,
          jobdetails,
          jobaskdate,
          jobasktime,
          jobdate,
          jobtime,
          jtimestamp);
      final Map<String, dynamic> data = note.toMap();

      await tx.set(ds.reference, data);
      await tx.set(dsp.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Note.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }
}

class DatabaseService {
  final Firestore _db = Firestore.instance;

 Stream<List<ServicesName>> streamWeapons(FirebaseUser user) {
    var ref = _db.collection('SERVICES');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => ServicesName.fromFirestore(doc)).toList());
  }
}