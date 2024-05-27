import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/Register/register.dart';

void SignIn(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SidebarApp()),
  );
}

void SignUp(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Register()),
  );
}
