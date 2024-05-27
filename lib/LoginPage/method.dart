import 'package:flutter/material.dart';
import 'package:mapvotersapk/Regiser/register.dart';

void SignIn() {}

void SignUp(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Register()),
  );
}
