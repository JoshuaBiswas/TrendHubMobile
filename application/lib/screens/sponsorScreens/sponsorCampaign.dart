import 'package:application/models/campaign.dart';
import 'package:application/screens/sponsorScreens/sponsorAddCampaign.dart';
import 'package:application/screens/sponsorScreens/sponsorCampaignInterface.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SponsorCampaign extends StatefulWidget {
  const SponsorCampaign({super.key});
  @override
  State<SponsorCampaign> createState() => _SponsorCampaignState();
}

class _SponsorCampaignState extends State<SponsorCampaign> {
  final _auth = AuthService();
  Campaign? campState;
  @override
  Widget build(BuildContext context) {
    ListTile add = ListTile(
      title: const Text('Add'),
      onTap: () {
        setState(() {
          campState = null;
        });
      },
    );
    return Scaffold(
        drawer: Drawer(
            backgroundColor: Colors.blueAccent.shade100,
            child: FutureProvider<List<ListTile>>(
                create: (buildContext) async {
                  List<Campaign> asCampaigns =
                      await DatabaseService(uid: Globals.currentUser.uid)
                          .getMyCampaigns();
                  List<ListTile> tiles = [add];
                  for (var camp in asCampaigns) {
                    ListTile tile = ListTile(
                      title: Text(camp.name),
                      onTap: () {
                        setState(() {
                          campState = camp;
                        });
                      },
                    );
                    tiles.add(tile);
                  }
                  return tiles;
                },
                initialData: [add],
                builder: ((context, child) {
                  List<ListTile> campaigns = context.watch<List<ListTile>>();
                  return ListView.separated(
                    itemCount: campaigns.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return campaigns[index];
                    },
                  );
                }))),
        body: campState == null
            ? SponsorAddCampaign()
            : SponsorCampaignInterface(campState!),
        appBar: AppBar(
          title: const Text("Welcome Sponsor!"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ));
  }
}
