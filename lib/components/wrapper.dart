//@dart=2.9

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:money_box/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputWrapper extends StatelessWidget {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  take(context) async {
    if (firstController.text.isNotEmpty && lastController.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("firstname", firstController.text);
      prefs.setString("lastname", lastController.text);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text('Please fill all the fields'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: firstController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Enter your First Name',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: lastController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Enter your last Name',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              take(context);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.cyan[500],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Let's Go!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
