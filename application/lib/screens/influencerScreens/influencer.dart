import 'package:application/screens/influencerScreens/influencerCampaign.dart';
import 'package:application/screens/influencerScreens/influencerHome.dart';
import 'package:application/screens/influencerScreens/influencerLearn.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';

class Influencer extends StatefulWidget {
  Influencer({super.key});
  @override
  State<Influencer> createState() => _InfluencerState();
}

class _InfluencerState extends State<Influencer> {
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
              selectedIcon: Icon(Icons.lightbulb),
              icon: Icon(Icons.lightbulb_outlined),
              label: 'Learn',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.video_camera_front),
              icon: Icon(Icons.video_camera_front_outlined),
              label: 'Influence',
            )
          ],
        ),
        body: <Widget>[
          Container(
            alignment: Alignment.center,
            child: const InfluencerLearn(),
          ),
          Container(
            alignment: Alignment.center,
            child: const InfluencerHome(),
          ),
          Container(
            alignment: Alignment.center,
            child: const InfluencerCampaign(),
          ),
        ][currentPageIndex],
        appBar: AppBar(
          title: const Text("Welcome to Influencer Home!"),
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
