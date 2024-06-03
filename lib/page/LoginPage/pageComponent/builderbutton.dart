import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/WidgetCollection/button.dart';

Widget buildbutton(
    {required String hinttext,
    required BuildContext context,
    required Color warnatombol,
    required Color warnatext,
    required VoidCallback metod}) {
  return button(
    hinttext: hinttext,
    L: 10,
    T: 10,
    R: 10,
    B: 40,
    tinggi: 0,
    lebar: 0,
    warnatombol: warnatombol,
    warnatext: warnatext,
    metod: metod,
  );
}
