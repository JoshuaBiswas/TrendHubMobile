import 'package:application/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  //Return current UID
  Future<String> getCurrentUID() async {
    print(_userFromFireBaseUser(_auth.currentUser));
    return _userFromFireBaseUser(_auth.currentUser);
  }

  //create user obj based on FirebaseUser
  String _userFromFireBaseUser(fb.User? user) {
    if (user == null) {
      return "";
    }
    return user.uid;
  }

  //auth change user stream
  Stream<String> get uid {
    return _auth.authStateChanges().map((fb.User? user) {
      return _userFromFireBaseUser(user);
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
  Future registerWithEmailAndPassword(
      String email, String username, String password, bool type) async {
    try {
      fb.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fb.User? user = result.user;

      await DatabaseService(uid: user!.uid)
          .createUserData(username: username, type: type);

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
