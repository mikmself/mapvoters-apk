import 'package:flutter/material.dart';
import 'package:mapvotersapk/Regiser/register.dart';

void Masuk() {}

void Daftar(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Register()),
  );
}
