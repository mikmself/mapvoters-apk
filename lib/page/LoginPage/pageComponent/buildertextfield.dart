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
    L: 13,
    T: 20,
    R: 13,
    B: 0,
    lebar: 275,
    tinggi: 50,
  );
}
