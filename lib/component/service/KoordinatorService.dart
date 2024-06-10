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
        print('Koordinator berhasil diedit');
        // Perbarui data koordinator di daftar koorList
        KoordinatorModel editedKoordinator = koorList.firstWhere(
              (koordinator) => koordinator.id == id,
        );
        editedKoordinator.nik = NIK;
        editedKoordinator.foto = foto.path;
        editedKoordinator.user!.name = nama;
        editedKoordinator.user!.email = Email;
        editedKoordinator.user!.telephone = telp;
      } else {
        print('Gagal mengedit koordinator: ${response.reasonPhrase}');
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