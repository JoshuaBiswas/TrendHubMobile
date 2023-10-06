import 'package:application/screens/authenticate/register.dart';
import 'package:application/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            //Sign Up button
            TextButton(
              child: const Text("Sign Up"),
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ),
                );
              },
            ),

            //Login button
            TextButton(
              child: const Text("Login"),
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
            ),
          ],
        )
      ],
    ));
  }
}
