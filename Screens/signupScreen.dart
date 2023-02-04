///////////////////////////////////
import 'package:cloud_firestore/cloud_firestore.dart';
///////////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';
///////////////////////////////////
import 'package:flutter/material.dart';
///////////////////////////////////
import 'package:google_fonts/google_fonts.dart';

///////////////////////////////////
class signupScreen extends StatefulWidget {
  const signupScreen({super.key});
  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  ///this emailControl is used to save the text here by the TextField widget
  final _emailControl = TextEditingController();

  ///this passwordControl is used to save the text here by the TextField widget
  final _passwordControl = TextEditingController();

  ///this to create firestore instance to can used in the app
  final _firestore = FirebaseFirestore.instance;
  late User singedInUser;

  ///this to create FirebaseAuth instance to can used in the app
  final _auth = FirebaseAuth.instance;
///////////////////////////////////
  ///This method is to save the user signup infomation into the firebase
  Future SignUP() async {
    /// this widget is show circel in the screen until the user sign up
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    ///here the line are the create the user account depend on what user write in the Textfield
    await _auth.createUserWithEmailAndPassword(
        email: _emailControl.text.trim(),
        password: _passwordControl.text.trim());
    getCurrentUser();
    createDocument();
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/');
  }

///////////////////////////////////
///////////////////////////////////
  ///this method to create to document(Record) in the firestore depend the firebase auto genrate UserID to each user
  void createDocument() {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(singedInUser.uid);

    ///all allergies be fasle until the user change it depend what he/she have
    final userAllergy = {
      'email': singedInUser.email,
      'Eggs': false,
      'Wheat': false,
      'chocolate': false,
      'fish': false,
      'lactose': false,
      'mango': false,
      'milk': false,
      'nuts': false,
      'peanuts': false,
      'strawberry': false
    };

    docUser.set(userAllergy);
  }

///////////////////////////////////
  ///This method to take to Current user info
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

///////////////////////////////////
  ///Navigator to signup page
  void opensignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }
///////////////////////////////////

///////////////////////////////////
  ///Navigator to Sign in page
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
