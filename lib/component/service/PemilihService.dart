import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';

import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/PemilihModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/page/createpemilih.dart';

class PemilihService {
  GetAllDataPemilih() async {
    var request = http.Request(
        'GET',
        Uri.parse(BASE_URL +
            '/v2/pemilih-potensial/${loginData['userID']}/${loginData['role']}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      print(responseString);
      Map<String, dynamic> responsDecode = jsonDecode(responseString);
      List<dynamic> data = responsDecode['data'];
      pemilihlist.clear();
      for (var element in data) {
        pemilihlist.add(PemilihModel.fromJson(element));
      }
      print(pemilihlist[0]);
    } else {
      print(response.reasonPhrase);
    }
  }

  GetPemilihDetail(int id) async {
    try {
      var request =
          http.Request('GET', Uri.parse('$BASE_URL/pemilih-potensial/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responsDecode = jsonDecode(responseString);
        PemilihModel pemilih = PemilihModel.fromJson(responsDecode['data']);
        return pemilih;
      } else {
        print(response.reasonPhrase);
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  CreatePemilih(
      String nama,
      String nik,
      File fotoKtp,
      telephone,
      String tps,
      String provinsiId,
      String kabupatenId,
      String kecamatanId,
      String kelurahanId) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(BASE_URL + '/v2/pemilih-potensial'),
      );

      request.fields.addAll({
        'nama': nama,
        'nik': nik,
        'telephone': telephone,
        'tps': tps,
        'provinsi_id': provinsiId,
        'kabupaten_id': kabupatenId,
        'kecamatan_id': kecamatanId,
        'kelurahan_id': kelurahanId,
        'koordinator_id': loginData['userID'].toString(),
      });
      request.files
          .add(await http.MultipartFile.fromPath('foto_ktp', fotoKtp.path));

      // http.StreamedResponse response = await request.send();
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Response Data: $responseData');
      } else {
        var responseBody = await response.stream.bytesToString();
        print('Failed to create pemilih. Status code: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Terjadi kesalahan saat membuat Pemilih: $e');
      return;
    }
  }

  EditPemilih(
      int id,
      String nama,
      String nik,
      File fotoKtp,
      String telephone,
      String tps,
      int provinsiId,
      int kabupatenId,
      int kecamatanId,
      int kelurahanId) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$BASE_URL/pemilih-potensial/$id'),
      );
      request.fields.addAll({
        'nama': nama,
        'nik': nik,
        'telephone': telephone,
        'tps': tps,
        'provinsi_id': provinsiId.toString(),
        'kabupaten_id': kabupatenId.toString(),
        'kecamatan_id': kecamatanId.toString(),
        'kelurahan_id': kelurahanId.toString(),
        'kordinator_id': loginData['kordinatorID']!
      });
      if (fotoKtp.path.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('foto_ktp', fotoKtp.path));
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
        print('Gagal mengedit Pemilih: ${response.reasonPhrase}');
        String responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengedit Pemilih: $e');
    }
  }

  DeletePemilih(int id) async {
    try {
      var request = http.Request(
          'DELETE', Uri.parse(BASE_URL + '/v2/pemilih-potensial/$id'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Pemilih berhasil dihapus');
        pemilihlist.removeWhere((pemilih) => pemilih.id == id);
      } else {
        print('Gagal menghapus Pemilih: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat menghapus Pemilih: $e');
    }
  }
  
}
