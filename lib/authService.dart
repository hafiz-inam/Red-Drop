import 'package:firebase_auth/firebase_auth.dart';
import 'package:reddrop/databaseService.dart';
import 'package:reddrop/user.dart';

class AuthService {
  String uid;
  AuthService({this.uid});

  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, userEmail: user.email) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  signInAnnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      uid = user.uid;
    } catch (e) {
      String error = e.toString();
      print('error : $error');
    }
  }

  registerUsingEmailAndPass(String email, String password) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(
        'New User',
        'Phone Number',
        '',
        '',
        'https://firebasestorage.googleapis.com/v0/b/red-drop-3da52.appspot.com/o/Default%2Fsearchpng.com-men-profile-image-transparent-png-free-download.png?alt=media&token=b1c73156-4ef5-4c8f-be96-e0de1399b5d2',
        false,
      );
    } catch (e) {
      String error = e.toString();
      print('error : $error');
    }
  }

  signinUsingEmailAndPass(String email, String password) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      FirebaseUser user = result.user;
      print(user.uid);
    } catch (e) {
      String error = e.toString();
      print('error : $error');
    }
  }

  signUserOut() {
    try {
      _auth.signOut();
    } catch (e) {
      print('error' + e.toString());
    }
  }
}
