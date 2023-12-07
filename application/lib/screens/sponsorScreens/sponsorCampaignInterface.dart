import 'package:application/models/campaign.dart';
import 'package:application/models/user.dart';
import 'package:application/screens/sponsorScreens/noCreatives.dart';
import 'package:application/screens/sponsorScreens/sponsorChatInterface.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/constants.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SponsorCampaignInterface extends StatefulWidget {
  final Campaign campState;
  User? userState;
  SponsorCampaignInterface(this.campState, {super.key});

  @override
  State<SponsorCampaignInterface> createState() =>
      _SponsorCampaignInterfaceState();
}

class _SponsorCampaignInterfaceState extends State<SponsorCampaignInterface> {
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
                    textColor: widget.userState != null &&
                            user.uid == widget.userState!.uid
                        ? selectedTextColor
                        : textColor,
                    title: Text(user.username),
                    onTap: () {
                      setState(() {
                        widget.userState = user;
                      });
                      Navigator.of(context).pop();
                    },
                  );
                  tiles.add(tile);
                }
                return tiles;
              },
              initialData: [],
              builder: ((context, child) {
                List<ListTile> users = context.watch<List<ListTile>>();
                if (users.isEmpty) {
                  return const Center(
                      child: Text(
                    "No creatives currently in campaign",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.center,
                  ));
                }
                return ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return users[index];
                  },
                );
              }))),
      body: widget.userState == null
          ? NoCreatives()
          : SponsorChatInterface(widget.campState, widget.userState!),
    );
  }
}
