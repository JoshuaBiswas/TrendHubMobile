import 'package:application/models/campaign.dart';
import 'package:application/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference campaignCollection =
      FirebaseFirestore.instance.collection('campaigns');

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

  Future<List<Campaign>> getMyCampaigns() async {
    return campaignCollection.where("host", isEqualTo: uid).get().then(
      (QuerySnapshot qs) {
        List<Campaign> campaigns = [];
        for (var docSnapshot in qs.docs) {
          Campaign campaign = Campaign(uid: docSnapshot.id);
          Map<String, dynamic> docData =
              docSnapshot.data() as Map<String, dynamic>;
          campaign.hostUID = uid;
          campaign.description = docData["description"];
          campaign.expiration = docData["expiration"];
          campaign.name = docData["name"];
          campaigns.add(campaign);
        }
        return campaigns;
      },
      onError: (e) => print("Error querying my campaigns: $e"),
    );
  }

  Future addCampaign(
      String description, String expiration, String name, String notes) async {
    final data = <String, dynamic>{
      "description": description,
      "expiration": expiration,
      "host": uid,
      "name": name,
      "notes": notes,
    };
    return await campaignCollection.add(data);
  }
}
