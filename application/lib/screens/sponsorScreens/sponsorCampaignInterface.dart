import 'package:application/models/campaign.dart';
import 'package:application/utils/campaignCard.dart';
import 'package:flutter/material.dart';

class SponsorCampaignInterface extends StatefulWidget {
  final Campaign campState;
  const SponsorCampaignInterface(this.campState, {super.key});

  @override
  State<SponsorCampaignInterface> createState() =>
      _SponsorCampaignInterfaceState();
}

class _SponsorCampaignInterfaceState extends State<SponsorCampaignInterface> {
  @override
  Widget build(BuildContext context) {
    return CampaignCard(widget.campState);
  }
}
