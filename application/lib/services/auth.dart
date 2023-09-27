import 'package:application/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  User _userFromFireBaseUser(fb.User? user) {
    if (user == null) {
      return User(uid: "");
    }
    return User(uid: user.uid);
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges().map((fb.User? user) {
      if (user != null) {
        return _userFromFireBaseUser(user);
      } else {
        return User(uid: "");
      }
    });
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      fb.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fb.User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      fb.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fb.User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
