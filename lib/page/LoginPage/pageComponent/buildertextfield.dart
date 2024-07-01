import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/WidgetCollection/textfield.dart';

class BuilderTextfield extends StatelessWidget {
  const BuilderTextfield({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.color,
    required this.secure,
  });

  final TextEditingController controller;
  final String hinttext;
  final Color color;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      hintText: hinttext,
      controller: controller,
      color: color,
      leftMargin: 20,
      rightMargin: 20,
      topMargin: 10,
      bottomMargin: 10,
      height: 60,
      width: double.infinity,
      fontSize: 24,
      isSecure: secure,
    );
  }
}
