import 'package:application/models/user.dart';
import 'package:application/screens/brandScreens/brand.dart';
import 'package:application/screens/influencerScreens/influencer.dart';
import 'package:application/screens/landing.dart';
import 'package:application/screens/sharedScreens/loading.dart';
import 'package:application/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthListener extends StatelessWidget {
  const AuthListener({super.key});

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<String>(context);
    //return either to Brand/Influencer Home or Authenticate Widget
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
          initialData: User(uid: ""),
          builder: (context, child) {
            final val = context.watch<User>();
            switch (val.type) {
              case "BRAND":
                return Brand();
              case "INFLUENCER":
                return Influencer();
              default:
                return const Loading();
            }
          });
    }
  }
}
