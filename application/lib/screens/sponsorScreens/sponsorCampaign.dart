import 'package:application/models/campaign.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
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
            child: FutureProvider<List<Campaign>>(
          create: (buildContext) async {
            return DatabaseService(uid: await AuthService().getCurrentUID())
                .getMyCampaigns();
          },
          initialData: const [],
          builder: ((context, child) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: context.watch<List<Campaign>>().length,
              itemBuilder: (BuildContext context, int index) {
                Campaign campaign = context.read<List<Campaign>>()[index];
                return Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.lightBlue.shade100,
                    height: 180,
                    child: Text(
                        "${campaign.name} : ${campaign.description}\n\nExpiration: ${campaign.expiration}\nParticipating Creatives: ${index + 5}"));
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
                onPressed: () async {
                  DatabaseService(uid: await AuthService().getCurrentUID())
                      .addCampaign("Swweeet", "Love", "Pdeace", "Notes!");
                }),
          ],
        ),
        const Divider(height: 80),
      ],
    ));
  }
}
