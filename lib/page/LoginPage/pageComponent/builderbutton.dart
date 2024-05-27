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
    L: 20,
    T: 10,
    R: 20,
    B: 0,
    tinggi: 50,
    lebar: 0,
    warnatombol: warnatombol,
    warnatext: warnatext,
    metod: metod,
  );
}
