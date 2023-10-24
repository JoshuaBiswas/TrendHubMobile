import 'package:application/screens/sponsorScreens/sponsorCampaign.dart';
import 'package:application/screens/sponsorScreens/sponsorHome.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';

class Sponsor extends StatefulWidget {
  Sponsor({super.key});
  @override
  State<Sponsor> createState() => _SponsorState();
}

class _SponsorState extends State<Sponsor> {
  final _auth = AuthService();
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
        appBar: AppBar(
          title: const Text("Welcome Sponsor!"),
          backgroundColor: Colors.brown[400],
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
        ));
  }
}
