const String BASE_URL = "https://737f-182-2-79-153.ngrok-free.app/api";
String? token = "";

Map<String, dynamic> loginData = {
  "paslonID": 1,
  "userID": "2",
  "partaiID": "1",
  "nama": "Subani Irga Angelina Alam Sinurat",
  "email": "siaas@gmail.com",
  "telephone": "081233033303",
  "role": "paslon",
  "foto": "siaas.jpg",
  "type": "dprri",
  "nomor_urut": "1",
  "dapil": "Jawa Tengah VIII",
};

List<LoginModel> login = [];

class LoginModel {
  int? id;
  String? role;
  LoginModel({this.id, this.role});
}