import 'package:application/models/campaign.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfluencerCampaign extends StatelessWidget {
  const InfluencerCampaign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Campaigns:"),
      Expanded(
          child: FutureProvider<List<Campaign>>(
        create: (buildContext) async {
          return DatabaseService(uid: await AuthService().getCurrentUID())
              .getCampaigns();
        },
        initialData: const [],
        builder: ((context, child) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: context.watch<List<Campaign>>().length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 50,
                  child: Center(
                      child: Text(
                          '${context.watch<List<Campaign>>()[index].name}')));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }),
      )),
    ]));
  }
}
