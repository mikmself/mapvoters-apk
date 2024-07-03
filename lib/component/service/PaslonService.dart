import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/PartaiModel.dart';
import 'package:mapvotersapk/component/model/PaslonModel.dart';

class PaslonService {
  GetPaslonDetail() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('$BASE_URL/paslon/${loginData['userID']}'));
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

  Future<void> showPartai() async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/partai'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];

      partailist.clear();
      for (var element in data) {
        partailist.add(PartaiModel(id: element['id'], nama: element['nama']));
      }
      print(partailist);

      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  registerPaslon(
      String nama,
      String email,
      String telp,
      String pass,
      String type,
      String partai_id,
      String dapil,
      String noUrut,
      File foto) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(BASE_URL + '/v2/registerpaslon'));
      request.fields.addAll({
        'name': nama,
        'email': email,
        'telephone': telp,
        'password': pass,
        'type': 'gubernur',
        'nomor_urut': noUrut,
        'dapil': dapil,
        'partai_id': partai_id
      });
      request.files.add(await http.MultipartFile.fromPath('foto', foto.path));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
}
