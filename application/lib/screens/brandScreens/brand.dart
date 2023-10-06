import 'package:application/screens/brandScreens/brandCampaign.dart';
import 'package:application/screens/brandScreens/brandHome.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';

class Brand extends StatefulWidget {
  Brand({super.key});
  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
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
            child: const BrandHome(),
          ),
          Container(
            alignment: Alignment.center,
            child: const BrandCampaign(),
          ),
        ][currentPageIndex],
        appBar: AppBar(
          title: const Text("Welcome to Brand Home!"),
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
