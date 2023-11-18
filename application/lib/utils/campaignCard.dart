import 'package:application/models/campaign.dart';
import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  const CampaignCard(this.campaign, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 15.0,
        color: Colors.orangeAccent.shade100,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Image(image: NetworkImage(campaign.imageURL)),
            ListTile(
              leading: const Icon(Icons.person_2_outlined),
              title: Text(
                campaign.hostname,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    campaign.name + "\n",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(campaign.description)
                ],
              ),
            )
          ],
        ));
  }
}
