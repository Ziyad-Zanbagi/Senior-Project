///////////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';
///////////////////////////////////
import 'package:flutter/material.dart';
///////////////////////////////////
import 'package:google_fonts/google_fonts.dart';

///////////////////////////////////
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///this emailControl is used to save the text here by the TextField widget
  final _emailControl = TextEditingController();

  ///this passwordControl is used to save the text here by the TextField widget
  final _passwordControl = TextEditingController();

///////////////////////////////////
  ///the method to user sign in into the app
  Future SignIN() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailControl.text.trim(),
        password: _passwordControl.text.trim());

    Navigator.of(context).pop();
  }
///////////////////////////////////

///////////////////////////////////
  ///Navigator signup page
  void opensignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }
  ///////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('loginPage/صفحة الدخول'))),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Image.asset(
                'images/logo.png',
                width: 180,
                height: 180,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "sign in/تسجيل دخول",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Wlecome/مرحبا بك ",
                style: GoogleFonts.robotoCondensed(fontSize: 18),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                  'Email                                                                 الايميل',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _emailControl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'password                                                                 باسورد',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _passwordControl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'password',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: SignIN,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'Sign in/تسجيل الدخول',
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('not yet member/ليس عضوا بعد ?',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: opensignupScreen,
                      child: Text(
                        'signup now/التسجيل الان ',
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
