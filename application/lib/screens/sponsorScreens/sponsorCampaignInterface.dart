import 'package:application/models/campaign.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/sponsorScreens/noCreatives.dart';
import 'package:application/screens/sponsorScreens/sponsorChatInterface.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SponsorCampaignInterface extends StatefulWidget {
  final Campaign campState;
  const SponsorCampaignInterface(this.campState, {super.key});

  @override
  State<SponsorCampaignInterface> createState() =>
      _SponsorCampaignInterfaceState();
}

class _SponsorCampaignInterfaceState extends State<SponsorCampaignInterface> {
  User? userState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          backgroundColor: Colors.blueAccent.shade100,
          child: FutureProvider<List<ListTile>>(
              create: (buildContext) async {
                List<User> asUsers =
                    await DatabaseService(uid: Globals.currentUser.uid)
                        .getCreativesByCampaign(widget.campState);
                List<ListTile> tiles = [];
                for (var user in asUsers) {
                  ListTile tile = ListTile(
                    title: Text(user.username),
                    onTap: () {
                      setState(() {
                        userState = user;
                      });
                    },
                  );
                  tiles.add(tile);
                }
                return tiles;
              },
              initialData: [],
              builder: ((context, child) {
                List<ListTile> users = context.watch<List<ListTile>>();
                return ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return users[index];
                  },
                );
              }))),
      body: userState == null ? NoCreatives() : SponsorChatInterface(),
    );
  }
}
