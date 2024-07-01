const String BASE_URL = "https://5530-149-108-20-227.ngrok-free.app/api";
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
