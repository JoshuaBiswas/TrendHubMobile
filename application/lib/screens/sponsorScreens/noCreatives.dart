import 'package:application/shared/constants.dart';
import 'package:flutter/material.dart';

class NoCreatives extends StatelessWidget {
  const NoCreatives({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
          child: Text(
        "No creative selected. Swipe from the right to see a list of creatives in this campaign.",
        style: TextStyle(
          color: textColor,
          fontSize: 36,
        ),
        textAlign: TextAlign.center,
      )),
    );
  }
}
