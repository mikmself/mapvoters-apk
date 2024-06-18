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

      if (responseData['success'] == true) {
        print(responseData);
        login.clear();
        var datarole = responseData['data']['user'];
        var user = responseData['data']['logindata'];
        login.add(LoginModel(role: datarole['role'], id: user['id']));
        print(login);
        print(login[0].role);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        await Future.delayed(Duration(seconds: 2));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login Failed!'), backgroundColor: Colors.red),
        );
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check Your Internet'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
