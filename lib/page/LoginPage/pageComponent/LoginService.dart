import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';

class LoginService {
  Future<bool> auth(String email, String password, BuildContext context) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(BASE_URL + '/auth/login'));

    request.fields.addAll({
      'email': email,
      'password': password,
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);

      var _UserData = responseData['data']['user'];
      var _RoleID = responseData['data']['logindata'];
      var _token = responseData['data']['token'];

      loginData.addAll({
        "token": _token,
        "userID": _RoleID['id'],
        "nama": _UserData['name'],
        "role": _UserData['role'],
      });

      print(loginData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );

      return true;
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau Password Salah, Periksa Kembali!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } else if (response.statusCode == 422) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi Email atau Password'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak terhubung ke Internet!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
