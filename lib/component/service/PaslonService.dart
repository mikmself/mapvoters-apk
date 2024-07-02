import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/PaslonModel.dart';
class PaslonService{
  GetPaslonDetail() async {
    try {
      var request = http.Request('GET', Uri.parse('$BASE_URL/paslon/${loginData['userID']}'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responsDecode = jsonDecode(responseString);
        PaslonModel paslon = PaslonModel.fromJson(responsDecode['data']);
        return paslon;
      } else {
        print('Gagal mendapatkan detail paslon: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan saat mendapatkan detail paslon: $e');
      return null;
    }
  }
}