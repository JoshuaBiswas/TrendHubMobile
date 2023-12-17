import 'package:application/models/campaign.dart';
import 'package:application/screens/creativeScreens/creativeCampaignInterface.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/constants.dart';
import 'package:application/shared/globals.dart';
import 'package:application/utils/campaignCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreativeCampaign extends StatefulWidget {
  CreativeCampaign({super.key});
  @override
  State<CreativeCampaign> createState() => _CreativeCampaignState();
}

Widget searchWidget =
    Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  Expanded(
      child: FutureProvider<List<Campaign>>(
    create: (buildContext) async {
      return DatabaseService(uid: Globals.currentUser.uid)
          .getCreativeNewCampaigns();
    },
    initialData: const [],
    builder: ((context, child) {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: context.watch<List<Campaign>>().length,
        itemBuilder: (BuildContext context, int index) {
          Campaign campaign = context.read<List<Campaign>>()[index];
          return GestureDetector(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(campaign.name),
                    content: Text(
                        "Description: ${campaign.description}\nExpiration: ${campaign.expiration}"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          DatabaseService(uid: Globals.currentUser.uid)
                              .addCreativeCampaign(campaign.uid);
                          Navigator.pop(context, 'Join');
                        },
                        child: const Text('Join'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(child: CampaignCard(campaign)));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }),
  )),
]);

class _CreativeCampaignState extends State<CreativeCampaign> {
  Campaign? campState;
  @override
  Widget build(BuildContext context) {
    ListTile search = ListTile(
      textColor: campState == null ? selectedTextColor : textColor,
      title: const Text('Search', style: TextStyle(fontSize: 20)),
      onTap: () {
        setState(() {
          campState = null;
        });
        Navigator.of(context).pop();
      },
    );
    final _auth = AuthService();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Welcome Creative!"),
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
        ),
        drawer: Drawer(
            backgroundColor: drawerColor,
            child: FutureProvider<List<ListTile>>(
                create: (buildContext) async {
                  List<Campaign> asCampaigns =
                      await DatabaseService(uid: Globals.currentUser.uid)
                          .getCreativeCampaigns();
                  List<ListTile> tiles = [search];
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
                initialData: [search],
                builder: ((context, child) {
                  List<ListTile> creativeCampaigns =
                      context.watch<List<ListTile>>();
                  return ListView.separated(
                    itemCount: creativeCampaigns.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return creativeCampaigns[index];
                    },
                  );
                }))),
        body: campState == null
            ? searchWidget
            : CreativeCampaignInterface(campState!));
  }
}
