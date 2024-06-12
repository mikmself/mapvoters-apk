import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';

class KoordinatorService {
  GetAllDataKoordinator() async {
    var request =
    http.Request('GET', Uri.parse(BASE_URL + '/koordinator'),);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      print(responseString);
      Map<String, dynamic> responsDecode = jsonDecode(responseString);
      List<dynamic> data = responsDecode['data'];
      koorList.clear();
      for (var element in data) {
        koorList.add(KoordinatorModel.fromJson(element));
      }
      print(koorList.toString());
    } else {
      print(response.reasonPhrase);
    }
  }
  GetKoordinatorDetail(int id) async {
    try {
      var request = http.Request('GET', Uri.parse('$BASE_URL/koordinator/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responsDecode = jsonDecode(responseString);
        KoordinatorModel koordinator = KoordinatorModel.fromJson(responsDecode['data']);
        return koordinator;
      } else {
        print('Gagal mendapatkan detail koordinator: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan saat mendapatkan detail koordinator: $e');
      return null;
    }
  }

  CreateKoordinator(String nama, String NIK, String Email, String telp,
      String Password, File foto) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(BASE_URL+'/koordinator'),);
      request.fields.addAll({
        'name': nama,
        'email': Email,
        'telephone': telp,
        'password': Password,
        'nik': NIK,
        'paslon_id': loginData['paslonID']!,
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
  EditKoordinator(int id, String nama, String NIK, String Email, String telp,
      String Password, File foto) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$BASE_URL/koordinator/$id'),
      );
      request.fields.addAll({
        'name': nama,
        'email': Email,
        'telephone': telp,
        'password': Password,
        'nik': NIK,
        'paslon_id': loginData['paslonID']!,
      });
      if (foto.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseDecode =
        jsonDecode(responseBody) as Map<String, dynamic>;

        print(id.toString());
        print(request.fields.toString());
        print(responseDecode.toString());
      } else {
        print('Gagal mengedit koordinator: ${response.reasonPhrase}');
        String responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengedit koordinator: $e');
    }
  }
  DeleteKoordinator(int id) async {
    try {
      var request = http.Request('DELETE', Uri.parse('$BASE_URL/koordinator/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Koordinator berhasil dihapus');
        // Hapus koordinator dari daftar koorList
        koorList.removeWhere((koordinator) => koordinator.id == id);
      } else {
        print('Gagal menghapus koordinator: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat menghapus koordinator: $e');
    }
  }
}