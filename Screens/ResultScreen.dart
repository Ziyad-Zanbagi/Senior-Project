import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'getResult.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String result = "";
  bool? status_1;
  List? allergies;
  getResult? user;
  getDatt() async {
    try {
      final response = await http
          .get(Uri.parse("https://36d1-31-166-28-3.in.ngrok.io/tasks"));
      if (response.statusCode == 200) {
        print("conntion is working ");
        var responseData = jsonDecode(response.body);
        for (var singleUser in responseData) {
          user = getResult(
            id: singleUser["id"],
            allergies: singleUser["allergies"].cast<String>(),
            allergic: singleUser["allergic"],
          );
        }
        print(user!.id);
        allergies = user!.allergies;
        status_1 = user?.allergic;
        setState(() {
          result = jsonDecode(response.body).toString();
        });
      } else {
        print("no request");
      }
    } catch (e) {
      print("ERROR ===>$e");
    }
  }

  @override
  void initState() {
    getDatt();
    // await widget.tasksAPi.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Result/النتجية '),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (status_1 == false) ...[
              Image.asset(
                'images/green-tick-png-green-tick-icon-image-14141-1000.png',
                width: 100,
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.cyan),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: 300,
                width: double.infinity,
                child: Text(
                  '       هذا المنتج سليم وخالي من الحساسية \n                    صالح للاستخدام\nThis product doesnot contain any allergen\n                   its safe to consume',
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            if (status_1 == true) ...[
              Image.asset(
                'images/1200px-Eo_circle_red_letter-x.svg.png',
                width: 100,
                height: 100,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.cyan),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'You have allergies from that ',
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('$allergies',
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ]
          ]),
        ),
      ),
    );
  }
}
