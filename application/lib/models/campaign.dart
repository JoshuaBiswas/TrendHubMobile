import 'package:cloud_firestore/cloud_firestore.dart';

class Campaign {
  String uid = "";
  String name = "EMPTY";
  String description = "EMPTY";
  String expiration = "EMPTY";
  String hostUID = "EMPTY";
  String notes = "EMPTY";
  String hostname = "EMPTY";
  String imageURL =
      "https://i.ebayimg.com/images/g/yPQAAOSwdvpkXDbm/s-l1200.webp";
  Campaign({required this.uid});
  Campaign.qds(QueryDocumentSnapshot qds) {
    Map<String, dynamic> data = qds.data() as Map<String, dynamic>;
    uid = qds.id;
    name = data["name"] as String;
    description = data["description"] as String;
    expiration = data["expiration"] as String;
    hostUID = data["host"] as String;
    hostname = data["hostname"] as String;
  }
  Campaign.ds(DocumentSnapshot ds) {
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    uid = ds.id;
    name = data["name"] as String;
    description = data["description"] as String;
    expiration = data["expiration"] as String;
    hostUID = data["host"] as String;
    hostname = data["hostname"] as String;
  }
}
