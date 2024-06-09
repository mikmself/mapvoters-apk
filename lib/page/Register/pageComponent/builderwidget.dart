import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapvotersapk/component/WidgetCollection/dropDown.dart';
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
    L: 3,
    T: 20,
    R: 3,
    B: 0,
    lebar: 344,
    tinggi: 50,
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
    L: 13,
    T: 20,
    R: 13,
    B: 0,
  );
}
