// ignore_for_file: unnecessary_const, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:money_box/credit_card/card_screen.dart';
import 'package:money_box/expense/helper.dart';
import 'package:money_box/expense/home_expense.dart';
import 'package:money_box/mediminder/src/ui/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var first = '';
  @override
  void initState() {
    // TODO: implement initState

    fetchToken();
  }

  void fetchToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var x = pref.getString("firstname").toString();
    setState(() {
      first = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Stack(children: <Widget>[
              Positioned(
                top: 60,
                left: 0,
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
              const Positioned(
                  top: 100,
                  left: 10,
                  child: const Text(
                    'MoneyBox',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ))
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
          Positioned(
              top: 110,
              left: 20,
              child: Container(
                child: Text(
                  "Hello, ${first}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(12.0),
            child: Ink(
              decoration: const BoxDecoration(
                color: Palette.DarkGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    24.0,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Expense'),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(-10.0, 10.0),
                          blurRadius: 15.0,
                          spreadRadius: 4.0),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        24.0,
                      ),
                    ),
                    // color: Static.PrimaryColor,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 8.0,
                  ),
                  child:
                      // ignore: prefer_const_literals_to_create_immutables

                      Text(
                    'Transactions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BillPage(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(12.0),
              child: Ink(
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-10.0, 10.0),
                          blurRadius: 15.0,
                          spreadRadius: 4.0),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        24.0,
                      ),
                    ),
                    // color: Static.PrimaryColor,
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 8.0,
                  ),
                  child: Text(
                    'Bill Payment Reminder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      // fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardScreen(),
                  ),
                );
              },
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text("My Credit Card"),
            ),
          )
        ]),
      ),
    );
  }
}
