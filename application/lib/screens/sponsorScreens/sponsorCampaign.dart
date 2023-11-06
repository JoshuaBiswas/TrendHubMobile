import 'package:application/models/campaign.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/globals.dart';
import 'package:application/utils/campaignCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SponsorCampaign extends StatelessWidget {
  const SponsorCampaign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Divider(),
        const Text("Your campaigns:"),
        const Divider(),
        Expanded(
            child: StreamProvider<List<Campaign>>.value(
          value: DatabaseService(uid: Globals.currentUser.uid).getMyCampaigns(),
          initialData: const [],
          builder: ((context, child) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: context.watch<List<Campaign>>().length,
              itemBuilder: (BuildContext context, int index) {
                Campaign campaign = context.read<List<Campaign>>()[index];
                return CampaignCard(campaign);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text(
                  'Add new campaign',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Add new campaign, Sponsor!"),
                      content: const Text("Description:"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // DatabaseService(
                            //         uid: Globals.currentUser.uid)
                            //     .addCampaign(Campaign(uid: meercat));
                            Navigator.pop(context, 'Add');
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
        const Divider(height: 80),
      ],
    ));
  }
}
