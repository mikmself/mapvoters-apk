const String BASE_URL = "https://dfe4-112-78-156-235.ngrok-free.app/api";
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
