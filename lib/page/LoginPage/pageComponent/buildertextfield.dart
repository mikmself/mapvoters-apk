import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/WidgetCollection/textfield.dart';

Widget buildtextfield({
  required String hinttext,
  required TextEditingController controllerUse,
  required Color warna,
}) {
  return textfield(
    hinttext: hinttext,
    controllerUse: controllerUse,
    warna: warna,
    L: 0,
    T: 10,
    R: 0,
    B: 0,
    lebar: 350,
    tinggi: 70,
  );
}
