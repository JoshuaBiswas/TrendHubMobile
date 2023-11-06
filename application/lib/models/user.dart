import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid = "";
  String username = "";
  bool type = false;
  User({required this.uid, required this.username, required this.type});
  User.qds(QueryDocumentSnapshot qds) {
    Map<String, dynamic> data = qds.data() as Map<String, dynamic>;
    uid = qds.id;
    username = data["username"] as String;
    type = data["type"] as bool;
  }
}
