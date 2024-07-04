import 'package:flutter/material.dart';
import 'package:mapvotersapk/page/LoginPage/loginpage.dart';

void main(List<String> args) {
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  const MyApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: loginpage());
  }
}
