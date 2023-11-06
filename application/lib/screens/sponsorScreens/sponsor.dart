import 'package:application/screens/sponsorScreens/sponsorCampaign.dart';
import 'package:application/screens/sponsorScreens/sponsorHome.dart';
import 'package:flutter/material.dart';

class Sponsor extends StatefulWidget {
  Sponsor({super.key});
  @override
  State<Sponsor> createState() => _SponsorState();
}

class _SponsorState extends State<Sponsor> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.campaign),
            icon: Icon(Icons.campaign_outlined),
            label: 'Campaign',
          )
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const SponsorHome(),
        ),
        Container(
          alignment: Alignment.center,
          child: const SponsorCampaign(),
        ),
      ][currentPageIndex],
    );
  }
}
