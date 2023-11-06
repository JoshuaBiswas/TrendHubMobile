import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  String uid = "";
  String name = "EMPTY";
  String description = "EMPTY";
  String expiration = "EMPTY";
  String hostUID = "EMPTY";
  String notes = "EMPTY";
  String imageURL =
      "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg";
  Campaign({required this.uid});
  Campaign.qds(QueryDocumentSnapshot qds) {
    Map<String, dynamic> data = qds.data() as Map<String, dynamic>;
    uid = qds.id;
    name = data["name"] as String;
    description = data["description"] as String;
    expiration = data["expiration"] as String;
    hostUID = data["host"] as String;
  }
}
