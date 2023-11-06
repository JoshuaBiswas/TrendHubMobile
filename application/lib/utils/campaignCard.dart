import 'package:application/models/campaign.dart';
import 'package:flutter/material.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  const CampaignCard(this.campaign, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Image(
            image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
        Text(campaign.name),
        Text(campaign.uid),
      ],
    ));
  }
}
