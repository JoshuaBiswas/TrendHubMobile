import 'package:application/models/campaign.dart';
import 'package:application/models/message.dart';
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
  // final CollectionReference messageCollection =
  //     FirebaseFirestore.instance.collection('messages');

  //Create the user data
  Future createUserData({required String username, required bool type}) async {
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

  Stream<List<Campaign>> getMyCampaigns() {
    return campaignCollection.where("host", isEqualTo: uid).snapshots().map(
        (QuerySnapshot qs) => qs.docs.map((e) => Campaign.qds(e)).toList());
  }

  Future<List<Campaign>> getCampaigns() async {
    return campaignCollection.get().then(
      (QuerySnapshot qs) {
        List<Campaign> campaigns = [];
        for (var docSnapshot in qs.docs) {
          campaigns.add(Campaign.qds(docSnapshot));
        }
        return campaigns;
      },
      onError: (e) => print("Error querying my campaigns: $e"),
    );
  }

  Future addCampaign(Campaign campaign) async {
    final data = <String, dynamic>{
      "description": campaign.description,
      "expiration": campaign.expiration,
      "host": campaign.uid,
      "name": campaign.name,
      "notes": campaign.notes,
    };
    return await campaignCollection.add(data);
  }

  Future<List<Campaign>> getCreativeCampaigns() async {
    final docRef = userCollection.doc(uid);
    return docRef.get().then(
      (DocumentSnapshot doc) {
        List<dynamic> rawCampaignDynamics =
            (doc.data() as Map<String, dynamic>)["campaigns"];
        List<String> rawCampaigns = [];
        for (var campaignDynamic in rawCampaignDynamics) {
          rawCampaigns.add(campaignDynamic as String);
        }
        List<Campaign> campaigns = [];
        for (var campaignUID in rawCampaigns) {
          Campaign campaign = Campaign(uid: campaignUID);
          campaignCollection
              .doc(campaignUID)
              .get()
              .then((DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            campaign.hostUID = data["host"] as String;
          });
          campaigns.add(campaign);
        }
        return campaigns;
      },
      onError: (e) => print("Error reading user data: $e"),
    );
  }

  Stream<List<Message>> getMessages(String campaignUID) {
    return campaignCollection
        .doc(campaignUID)
        .collection("creatives")
        .doc(uid)
        .collection("messages")
        .snapshots()
        .map((QuerySnapshot querySnapshot) =>
            querySnapshot.docs.map((e) => Message.qds(e)).toList());
  }

  Future sendMessage(Message message, String campaignUID) async {
    final data = <String, dynamic>{
      "body": message.body,
      "creativeUID": message.creativeUID,
      "sponsorUID": message.sponsorUID,
      "sponsorSent": message.sponsorSent,
      "created": message.created,
    };
    return await campaignCollection
        .doc(campaignUID)
        .collection("creatives")
        .doc(uid)
        .collection("messages")
        .add(data);
  }

  Future addCreativeCampaign(String campaignUID) async {}
}
