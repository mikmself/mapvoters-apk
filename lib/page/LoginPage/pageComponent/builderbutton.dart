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
    L: 0,
    T: 20,
    R: 0,
    B: 0,
    tinggi: 50,
    lebar: 130,
    warnatombol: warnatombol,
    warnatext: warnatext,
    metod: metod,
  );
}
