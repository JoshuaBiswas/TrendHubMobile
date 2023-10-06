import 'package:application/firebase_options.dart';
import 'package:application/screens/authListener.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<String>.value(
      initialData: "",
      value: AuthService().uid,
      child: const MaterialApp(
        home: AuthListener(),
      ),
    );
  }
}
