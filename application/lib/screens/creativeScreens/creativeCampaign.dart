import 'package:application/models/campaign.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreativeCampaign extends StatelessWidget {
  const CreativeCampaign({super.key});

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
                            onPressed: () => Navigator.pop(context, 'Join'),
                            child: const Text('Join'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                      height: 100,
                      color: Colors.blue.shade100,
                      child: Center(
                          child: Text(
                              "${campaign.name} : ${campaign.description}"))));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }),
      )),
    ]));
  }
}
