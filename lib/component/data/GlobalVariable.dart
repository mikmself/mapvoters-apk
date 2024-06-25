const String BASE_URL = "https://d395-182-2-52-139.ngrok-free.app/api";
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
