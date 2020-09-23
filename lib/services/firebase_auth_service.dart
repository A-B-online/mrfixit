import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class User {
  const User({@required this.uid, this.name, this.email, this.imageUrl});
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
}

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleAccount;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    print(googleAuth.accessToken);
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    return _userFromFirebase(user);
  }

  User _userFromFirebase(FirebaseUser user) {
    return user == null
        ? null
        : User(
            uid: user.uid,
            name: user.displayName,
            email: user.email,
            imageUrl: user.photoUrl);
  }

  Stream<User> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
