import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String body = "";
  String creativeUID = "";
  String sponsorUID = "";
  MessageType type = MessageType.text;
  bool sponsorSent = false;
  Timestamp created = Timestamp.now();
  Message();
  Message.qds(QueryDocumentSnapshot qds) {
    Map<String, dynamic> data = qds.data() as Map<String, dynamic>;
    body = data["body"] as String;
    creativeUID = data["creativeUID"] as String;
    sponsorUID = data["sponsorUID"] as String;
    sponsorSent = data["sponsorSent"] as bool;
    created = data["created"] as Timestamp;
  }
  static List<Message> sortByTime(List<Message> list) {
    list.sort(
      (a, b) => a.created.microsecondsSinceEpoch
          .compareTo(b.created.microsecondsSinceEpoch),
    );
    return list;
  }
}

enum MessageType { text, payment, fulfillment }
