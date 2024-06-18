import 'package:flutter/material.dart';

class LoginController {
  Future<bool> auth(String email, String password, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    const String correctEmail = "superadmin";
    const String correctPassword = "bodoh";

    if (email == correctEmail && password == correctPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
