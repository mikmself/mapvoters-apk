import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapvotersapk/component/WidgetCollection/dropDown.dart';
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
      T: 0,
      R: 20,
      B: 0,
      fontsize: 20,
      lebar: 0,
      tinggi: 0,
    ),
  );
}

Widget builddropdown(
    {required String hinttext,
    required List<String> list,
    required TextEditingController controllerUse,
    required Color warna,
    required ValueChanged<String?> metod}) {
  return MyDropdownMenu(
    field: list,
    hint: hinttext,
    controllerUse: controllerUse,
    onSelected: metod,
    L: 20,
    T: 0,
    R: 20,
    B: 0,
  );
}
