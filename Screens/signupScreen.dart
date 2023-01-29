import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final _emailControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  late User singedInUser;
  final _auth = FirebaseAuth.instance;

  Future SignUP() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await _auth.createUserWithEmailAndPassword(
        email: _emailControl.text.trim(),
        password: _passwordControl.text.trim());
    getCurrentUser();
    createUser();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/');
  }

  void createUser() {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(singedInUser.uid);

    final info = {
      'Eggs': false,
      'Wheat': false,
      'chocolate': false,
      'email': singedInUser.email,
      'fish': false,
      'lactose': false,
      'mango': false,
      'milk': false,
      'nuts': false,
      'peanuts': false,
      'strawberry': false
    };

    docUser.set(info);
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void opensignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  void SignINpage() {
    Navigator.of(context).pushReplacementNamed('LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('SignUp Page/التسجيل'))),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Image.asset(
                'images/logo.png',
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "sign up/تسجيل ",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Wlecome here you can sign up ",
                style: GoogleFonts.robotoCondensed(fontSize: 18),
              ),
              Text('/مرحبا بك هنا يمكنك التسجيل ',
                  style: GoogleFonts.robotoCondensed(fontSize: 18)),
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
                child: GestureDetector(
                  onTap: () {
                    SignUP();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      'Sign up/التسجيل',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already a member/عضوا فعلا  ?',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: SignINpage,
                      child: Text(
                        'sign here/سجل دخول هنا  ',
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
