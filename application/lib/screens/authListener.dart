import 'package:application/models/user.dart';
import 'package:application/screens/authenticate/authenticate.dart';
import 'package:application/screens/influencerScreens/influencerHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either to Brand/Influencer Home or Authenticate Widget
    if (user.uid == "") {
      return const Authenticate();
    } else {
      return influencerHome();
    }
  }
}
