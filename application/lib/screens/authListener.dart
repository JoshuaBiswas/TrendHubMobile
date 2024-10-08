import 'package:application/models/user.dart';
import 'package:application/screens/sponsorScreens/sponsor.dart';
import 'package:application/screens/creativeScreens/creative.dart';
import 'package:application/screens/landing.dart';
import 'package:application/screens/sharedScreens/loading.dart';
import 'package:application/services/database.dart';
import 'package:application/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthListener extends StatelessWidget {
  const AuthListener({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<String>(context);
    //return either to Sponsor/Creative Home or Authenticate Widget
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    if (uid == "") {
      return const Landing();
    } else {
      return FutureProvider<User>(
          create: (buildContext) {
            return DatabaseService(uid: uid).createUserObject();
          },
          initialData: User(uid: "", username: "", type: false),
          builder: (context, child) {
            Globals.currentUser = context.watch<User>();
            if (Globals.currentUser.uid == "") {
              return const Loading();
            } else if (Globals.currentUser.type) {
              return Sponsor();
            } else {
              return Creative();
            }
          });
    }
  }
}
