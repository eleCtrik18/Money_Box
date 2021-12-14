import 'package:flutter/material.dart';
import 'package:money_box/credit_card/card.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: CreditCard(),
      ),
    );
  }
}
