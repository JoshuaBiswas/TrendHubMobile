import 'package:application/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //Create the user data
  Future createUserData(
      {required String username, required String type}) async {
    final data = <String, dynamic>{
      "username": username,
      "type": type,
    };
    return await userCollection.doc(uid).set(data).onError(
        (error, stackTrace) => print("Error creating user data: $error"));
  }

  //Read the user data
  Future<Map<String, dynamic>> readUserData() async {
    final docRef = userCollection.doc(uid);
    return docRef.get().then(
      (DocumentSnapshot doc) {
        return doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error reading user data: $e"),
    );
  }

  Future<User> createUserObject() async {
    Map<String, dynamic> data = await readUserData();
    User user = User(uid: uid);
    user.type = data["type"];
    return user;
  }
}
