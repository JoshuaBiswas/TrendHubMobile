import 'package:application/models/campaign.dart';
import 'package:application/services/auth.dart';
import 'package:application/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandCampaign extends StatelessWidget {
  const BrandCampaign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Your campaigns:"),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text(
                  '+',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  DatabaseService(uid: await AuthService().getCurrentUID())
                      .addCampaign("Swweeet", "Love", "Pdeace", "Notes!");
                }),
          ],
        ),
      ],
    ));
  }
}
