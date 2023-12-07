import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid = "";
  String username = "";
  bool type = false;
  User({required this.uid, required this.username, required this.type});
  User.ds(DocumentSnapshot ds) {
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    uid = ds.id;
    username = data["username"] as String;
    type = data["type"] as bool;
  }
}

enum UserType { creative, sponsor }
