///////////////////////////////////
import 'package:flutter/material.dart';
///////////////////////////////////
import 'package:sniorproject_app/Screens/ResultScreen.dart';
///////////////////////////////////
import 'package:sniorproject_app/screens/HomeScreen.dart';
///////////////////////////////////
import 'package:sniorproject_app/screens/LoginScreen.dart';
///////////////////////////////////
import 'package:firebase_core/firebase_core.dart';
///////////////////////////////////
import 'package:sniorproject_app/screens/SetAlleriges.dart';
///////////////////////////////////
import 'package:sniorproject_app/screens/signupScreen.dart';
///////////////////////////////////
import 'Auth.dart';
import 'Screens/Customersupport.dart';
///////////////////////////////////

void main() async {
  /// this two lines must use when use firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const app());
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///this line to remove the debug banner this banner are automatic genrate by the flutter
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      //this line are used to help the devloper in navgotor between pages
      routes: {
        '/': (context) => const Auth(),
        'HomeScreen': (context) => const HomeScreen(),
        'signupScreen': (context) => const signupScreen(),
        'LoginScreen': (context) => const LoginScreen(),
        'SetAlleriges': (context) => const SetAlleriges(),
        'ResultScreen': (context) => const ResultScreen(),
        'Customersupport': (context) => const Customersupport(),
      },
    );
  }
}
