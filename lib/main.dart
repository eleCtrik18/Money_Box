//@dart = 2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_box/homepage.dart';
import 'package:money_box/initial_screen.dart';
import 'package:money_box/mediminder/src/global_bloc.dart';
import 'package:provider/provider.dart';

import 'mediminder/src/ui/homepage/homepage.dart';

void main() {
  runApp(MedicineReminder());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.05),
      statusBarColor: Colors.black.withOpacity(0.05),
      statusBarIconBrightness: Brightness.dark));
}

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.light,
        ),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
