import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'getResult.dart';
import 'package:url_launcher/url_launcher.dart';

class Customersupport extends StatefulWidget {
  const Customersupport({super.key});

  @override
  State<Customersupport> createState() => Customersupportclass();
}

class Customersupportclass extends State<Customersupport> {
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Customer Support /الدعم الفني  '),
        ),
        body: Center(
          child: Column(children: [
            Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    maxLines: 8, //or null
                    decoration: InputDecoration.collapsed(
                        hintText: "Customer support /الدعم الفني "),
                  ),
                )),
            ElevatedButton(
              onPressed: () {
                String s = myController.text;
                launch(
                    'mailto:allergendetector@gmail.com?subject=Customer Support&body=$s');
                Navigator.of(context).pushNamed('HomeScreen');
              },
              child: const Text("send Email/ارسال الايميل"),
            )
          ]),
        ),
      ),
    );
  }
}
