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
    return await docRef.get().then(
      (DocumentSnapshot doc) {
        return doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error reading user data: $e"),
    );
  }

  Future<User> createUserObject() async {
    Map<String, dynamic> data = await readUserData();
    return User(uid: uid, username: data["username"], type: data["type"]);
  }

  Future<List<Campaign>> getMyCampaigns() {
    return campaignCollection.where("host", isEqualTo: uid).get().then(
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

  Future<List<Campaign>> getCampaigns() async {
    return await campaignCollection.get().then(
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
      "host": campaign.hostUID,
      "hostname": campaign.hostname,
      "name": campaign.name,
      "notes": campaign.notes,
    };
    return await campaignCollection.add(data);
  }

  Future<List<Campaign>> getCreativeCampaigns() async {
    return await userCollection
        .doc(uid)
        .collection("campaigns")
        .get()
        .then((QuerySnapshot qs) async {
      List<Campaign> campaigns = [];
      for (var docSnapshot in qs.docs) {
        await campaignCollection
            .doc(docSnapshot.id)
            .get()
            .then((DocumentSnapshot ds) async {
          campaigns.add(Campaign.ds(ds));
        });
      }
      return campaigns;
    });
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
      "type": "text",
    };
    return await campaignCollection
        .doc(campaignUID)
        .collection("creatives")
        .doc(uid)
        .collection("messages")
        .add(data);
  }

  Future sendPaymentMessage(Campaign campState, User userState) async {
    final data = <String, dynamic>{
      "body": "Sponsor has just paid Creative for their service",
      "creativeUID": userState.uid,
      "sponsorUID": campState.hostUID,
      "sponsorSent": true,
      "created": Timestamp.now(),
      "type": "payment",
    };
    return await campaignCollection
        .doc(campState.uid)
        .collection("creatives")
        .doc(uid)
        .collection("messages")
        .add(data);
  }

  //called when creative joins a campaign
  Future addCreativeCampaign(String campaignUID) async {
    await campaignCollection
        .doc(campaignUID)
        .collection("creatives")
        .doc(uid)
        .set({});
    await userCollection
        .doc(uid)
        .collection("campaigns")
        .doc(campaignUID)
        .set({});
  }

  Future<List<User>> getCreativesByCampaign(Campaign campaign) async {
    return await campaignCollection
        .doc(campaign.uid)
        .collection("creatives")
        .get()
        .then((QuerySnapshot qs) async {
      List<User> users = [];
      for (var docSnapshot in qs.docs) {
        users.add(User.ds(await userCollection.doc(docSnapshot.id).get()));
      }
      return users;
    });
  }

  Future<List<Campaign>> getCreativeNewCampaigns() async {
    List<Campaign> campaigns = await getCampaigns();
    List<Campaign> creativeCampaigns = await getCreativeCampaigns();
    List<Campaign> res = [];
    Set<String> unique = Set();
    for (Campaign campaign in creativeCampaigns) {
      unique.add(campaign.uid);
    }
    for (Campaign campaign in campaigns) {
      if (!unique.contains(campaign.uid)) {
        res.add(campaign);
      }
    }
    return res;
  }
}
