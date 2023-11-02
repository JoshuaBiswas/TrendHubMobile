import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String body = "";
  String creativeUID = "";
  String sponsorUID = "";
  bool sponsorSent = false;
  Timestamp created = Timestamp.now();
}
