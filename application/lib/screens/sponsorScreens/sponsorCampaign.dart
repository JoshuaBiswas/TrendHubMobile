import 'package:application/models/campaign.dart';
import 'package:application/screens/sponsorScreens/sponsorAddCampaign.dart';
import 'package:application/screens/sponsorScreens/sponsorCampaignInterface.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/constants.dart';
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
      textColor: campState == null ? selectedTextColor : textColor,
      title: const Text('Add', style: TextStyle(fontSize: 20)),
      onTap: () {
        setState(() {
          campState = null;
        });
        Navigator.of(context).pop();
      },
    );
    return Scaffold(
        drawer: Drawer(
            backgroundColor: drawerColor,
            child: FutureProvider<List<ListTile>>(
                create: (buildContext) async {
                  List<Campaign> asCampaigns =
                      await DatabaseService(uid: Globals.currentUser.uid)
                          .getMyCampaigns();
                  List<ListTile> tiles = [add];
                  for (var camp in asCampaigns) {
                    ListTile tile = ListTile(
                      textColor:
                          (campState != null) && campState!.name == camp.name
                              ? selectedTextColor
                              : textColor,
                      title: Text(camp.name),
                      onTap: () {
                        setState(() {
                          campState = camp;
                        });
                        Navigator.of(context).pop();
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
          backgroundColor: headerColor,
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
