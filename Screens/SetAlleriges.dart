///////////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';
///////////////////////////////////
import 'package:flutter/material.dart';
///////////////////////////////////
import 'package:cloud_firestore/cloud_firestore.dart';
///////////////////////////////////
import 'package:google_fonts/google_fonts.dart';

///////////////////////////////////
class SetAlleriges extends StatefulWidget {
  const SetAlleriges({super.key});
  @override
  State<SetAlleriges> createState() => _SetAllerigesState();
}

class _SetAllerigesState extends State<SetAlleriges> {
  ///this to create firestore instance to can used in the app
  final _firestore = FirebaseFirestore.instance;
  bool milk = false;
  bool nuts = false;
  bool fish = false;
  bool strawberry = false;
  bool Eggs = false;
  bool Wheat = false;
  bool Lactose = false;
  bool Mango = false;
  bool chocolate = false;
  bool Peanuts = false;
  final user = FirebaseAuth.instance.currentUser!;
  ///////////////////////////////////
  /// to update  user Allergies
  void UpdateUser() {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(user.uid);
    final userinfo = {
      'Eggs': Eggs,
      'Wheat': Wheat,
      'chocolate': chocolate,
      'email': user.email,
      'fish': fish,
      'lactose': Lactose,
      'mango': Mango,
      'milk': milk,
      'nuts': nuts,
      'peanuts': Peanuts,
      'strawberry': strawberry
    };
    docUser.update(userinfo);
  }

///////////////////////////////////
///////////////////////////////////
  ///Navigator to home page
  void backhome() {
    Navigator.of(context).pushNamed('HomeScreen');
  }

  @override
  Widget build(BuildContext context) {
    ///this check box to user select the allergies
    return Scaffold(
        appBar: AppBar(title: const Text('Alleriges/الحساسيات')),
        body: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            CheckboxListTile(
              value: milk,
              onChanged: (val) {
                setState(() {
                  milk = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('Milk/حليب',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            CheckboxListTile(
                value: nuts,
                onChanged: (val) {
                  setState(() {
                    nuts = val!;
                  });
                },
                activeColor: Colors.blue,
                title: Text('Nuts/مكسرات',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))),
            CheckboxListTile(
                value: fish,
                onChanged: (val) {
                  setState(() {
                    fish = val!;
                  });
                },
                activeColor: Colors.blue,
                title: Text('Fish/سمك',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))),
            CheckboxListTile(
                value: strawberry,
                onChanged: (val) {
                  setState(() {
                    strawberry = val!;
                  });
                },
                activeColor: Colors.blue,
                title: Text('Strawberry/فراولة',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18))),
            CheckboxListTile(
              value: Eggs,
              onChanged: (val) {
                setState(() {
                  Eggs = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('Eggs/بيض',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            CheckboxListTile(
              value: Wheat,
              onChanged: (val) {
                setState(() {
                  Wheat = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('Wheat/قمح',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            CheckboxListTile(
              value: Lactose,
              onChanged: (val) {
                setState(() {
                  Lactose = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('Lactose/اللاكتوز',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            CheckboxListTile(
              value: Mango,
              onChanged: (val) {
                setState(() {
                  Mango = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('Mango/مانجو',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            CheckboxListTile(
              value: chocolate,
              onChanged: (val) {
                setState(() {
                  chocolate = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('chocolate/شوكولاته',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            CheckboxListTile(
              value: Peanuts,
              onChanged: (val) {
                setState(() {
                  Peanuts = val!;
                });
              },
              activeColor: Colors.blue,
              title: Text('Peanuts/فول السوداني',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                  UpdateUser();

                  Navigator.of(context).pop();
                  backhome();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    'Set the Allergies/تسجيل الحساسيات',
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
