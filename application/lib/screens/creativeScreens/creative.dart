import 'package:application/screens/creativeScreens/creativeCampaign.dart';
import 'package:application/screens/creativeScreens/creativeHome.dart';
import 'package:application/screens/creativeScreens/creativeLearn.dart';
import 'package:flutter/material.dart';

class Creative extends StatefulWidget {
  Creative({super.key});
  @override
  State<Creative> createState() => _CreativeState();
}

class _CreativeState extends State<Creative> {
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
            label: 'Create',
          )
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const CreativeLearn(),
        ),
        Container(
          alignment: Alignment.center,
          child: const CreativeHome(),
        ),
        Container(
          alignment: Alignment.center,
          child: CreativeCampaign(),
        ),
      ][currentPageIndex],
    );
  }
}
