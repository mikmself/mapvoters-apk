import 'package:get/get.dart';
import 'package:mapvotersapk/page/LoginPage/loginprovider.dart';

class LoginController extends GetxController {
  void auth(String email, String password) {
    var data = {
      "id": email,
      "title": password,
    };
    Loginprovider().auth(data).then(
      (value) {
        if (value.statusCode == 200) {
          print("Login Sukses");
        } else {
          print('Login Failed');
        }
      },
    );
  }
}
