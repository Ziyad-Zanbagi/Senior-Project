import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
/////////////////////
import 'package:flutter/material.dart';
///////////////////////////////////
import 'package:flutter/services.dart';
///////////////////////////////////
import 'package:google_fonts/google_fonts.dart';
///////////////////////////////////

import 'package:image_picker/image_picker.dart';
///////////////////////////////////
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference userref = FirebaseFirestore.instance.collection('Users')
      as CollectionReference<Object?>;
  late bool milk;
  late bool nuts;
  late bool fish;
  late bool strawberry;
  late bool Eggs;
  late bool Wheat;
  late bool Lactose;
  late bool Mango;
  late bool chocolate;
  late bool Peanuts;
  File? _image;
  Uint8List? bytes;
  String? img64;

  Future<void> getImage(ImageSource source) async {
    var picker = ImagePicker();
    PickedFile? image;
    image = await picker.getImage(source: source);
    if (image!.path.isEmpty == false) {
      setState(() {
        _image = File(image!.path);
      });
      bytes = File(_image!.path).readAsBytesSync();
      img64 = base64Encode(bytes!);
    } else {
      if (kDebugMode) {
        print('null');
      }
    }

    http.post(
      Uri.parse(
          'https://d977-2a02-9b0-402b-d298-10c9-2e2f-13a9-243a.eu.ngrok.io/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': user.uid,
        'eggs': Eggs.toString(),
        'wheat': Wheat.toString(),
        'lactose': Lactose.toString(),
        'mango': Mango.toString(),
        'chocolate': chocolate.toString(),
        'peanuts': Peanuts.toString(),
        'fish': fish.toString(),
        'nuts': nuts.toString(),
        'milk': milk.toString(),
        'strawberry': strawberry.toString(),
        'image': img64!,
      }),
    );
  }

  void SetAellergies() async {
    await userref.doc(user.uid).get().then((value) => {
          Eggs = value.get('Eggs'),
          Lactose = value.get('lactose'),
          Wheat = value.get('Wheat'),
          chocolate = value.get('chocolate'),
          fish = value.get('fish'),
          Mango = value.get('mango'),
          milk = value.get('milk'),
          nuts = value.get('nuts'),
          Peanuts = value.get('peanuts'),
          strawberry = value.get('strawberry')
        });
  }

  void SetAller() {
    Navigator.of(context).pushNamed('SetAlleriges');
  }

  void ResultScr() {
    Navigator.of(context).pushNamed('ResultScreen');
  }

  @override
  Widget build(BuildContext context) {
    final email = user.email!;

    return Scaffold(
      appBar:
          AppBar(title: const Center(child: Text('Homepage/الصفحة الرئيسة'))),
      body: SingleChildScrollView(
        child: Center(
            child: Column(children: [
          Row(
            children: [
              const Icon(
                Icons.account_box_outlined,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Text(
                  email,
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Image.asset(
            'images/logo.png',
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: (() {
                FirebaseAuth.instance.signOut();
              }),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.logout_outlined, color: Colors.white),
                    Center(
                        child: Text(
                      '          Sign out/تسجيل الخروج',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: SetAller,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.checklist_outlined, color: Colors.white),
                    Center(
                        child: Text(
                      '  SetAlleriges/تسجيل الحساسيات',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
                SetAellergies();
                getImage(ImageSource.gallery);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
                timerup();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Row(
                  children: [
                    const Icon(Icons.mms_outlined, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'Select Image/اختيار صورة',
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  SetAellergies();
                  getImage(ImageSource.camera);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                  timerupCamera();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Row(
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text(
                          'Photoshot/تصوير بالكاميرا',
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  )),
                ),
              )),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('Customersupport');
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Row(
                    children: [
                      const Icon(Icons.contact_support, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text(
                          'Customer Support/الدعم الفني',
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  )),
                ),
              ))
        ])),
      ),
    );
  }

  void timerup() {
    Timer(Duration(seconds: 20), () {
      setState(() async {
        ResultScr();
      });
    });
  }

  void timerupCamera() {
    Timer(Duration(seconds: 40), () {
      setState(() async {
        ResultScr();
      });
    });
  }
}
