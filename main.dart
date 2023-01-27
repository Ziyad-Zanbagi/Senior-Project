import 'package:flutter/material.dart';
import 'package:sniorproject_app/screens/HomeScreen.dart';
import 'package:sniorproject_app/screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sniorproject_app/screens/SetAlleriges.dart';
import 'package:sniorproject_app/screens/signupScreen.dart';

import 'Auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const app());
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      // home: const Auth(),
      routes: {
        '/': (context) => const Auth(),
        'HomeScreen': (context) => const HomeScreen(),
        'signupScreen': (context) => const signupScreen(),
        'LoginScreen': (context) => const LoginScreen(),
        'SetAlleriges': (context) => const SetAlleriges(),
      },
    );
  }
}
