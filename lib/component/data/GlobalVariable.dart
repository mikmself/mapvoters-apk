const String BASE_URL = "https://1b9e-182-2-84-32.ngrok-free.app/api";
String? token = "";

Map<String, dynamic> loginData = {

  "token": "",
  "userID": "",
  "nama": "",
  "role": "",
};

List<LoginModel> login = [];

class LoginModel {
  int? id;
  String? role;
  LoginModel({this.id, this.role});
}
