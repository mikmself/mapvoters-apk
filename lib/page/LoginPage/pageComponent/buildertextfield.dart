import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/WidgetCollection/textfield.dart';

Widget buildtextfield({
  required String hinttext,
  required TextEditingController controllerUse,
  required Color warna,
}) {
  return Expanded(
    child: textfield(
      hinttext: hinttext,
      controllerUse: controllerUse,
      warna: warna,
      L: 20,
      T: 10,
      R: 20,
      B: 10,
      fontsize: 24,
      lebar: 0,
      tinggi: 0,
    ),
  );
}
