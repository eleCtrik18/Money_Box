// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  var first = '';
  var last = '';
  @override
  void initState() {
    // TODO: implement initState

    fetchdetails();
  }

  void fetchdetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var x = pref.getString("firstname").toString();
    var y = pref.getString("lastname").toString();
    setState(() {
      first = x;
      last = y;
    });
  }

  double horizontalDrag = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (horizontal) {
        setState(() {
          horizontalDrag += horizontal.delta.dx;
          horizontalDrag %= 360;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(pi / 180 * horizontalDrag),
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: const [Color(0xff326244), Color(0xff004024)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: horizontalDrag <= 90 || horizontalDrag >= 270
              ? cardFront()
              : cardBack(),
        ),
      ),
    );
  }

  Widget cardFront() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Text(
                'MoneyBox',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              Text(
                '|',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 10,
                  fontSize: 10,
                ),
              ),
              Text(
                'Platinum',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          // Image.asset(
          //   'assets/images/chip.png',
          //   height: 25,
          // ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${first} ${last}',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '1234 5678 9101 1121',
            style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
                wordSpacing: 15,
                shadows: const [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  )
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '05 / 26',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget cardBack() {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.grey[700],
          )
        ],
      ),
    );
  }
}
