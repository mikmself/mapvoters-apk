const String BASE_URL = "https://3c17-139-192-202-152.ngrok-free.app/api";
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
