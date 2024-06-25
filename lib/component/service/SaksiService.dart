import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';

class SaksiService {
  GetAllDataSaksi() async {
    var request = http.Request(
      'GET',
      Uri.parse(BASE_URL + '/saksi'),
    );

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      print(responseString);
      Map<String, dynamic> responsDecode = jsonDecode(responseString);
      print(responsDecode);
      List<dynamic> data = responsDecode['data'];
      print(data);
      saksiListan.clear();
      for (var element in data) {
        saksiListan.add(SaksiModel.fromJson(element));
        print(element);
      }
      print(saksiListan);
    } else {
      print(response.reasonPhrase);
    }
  }
  GetSaksiDetail(int id) async {
    try {
      var request = http.Request('GET', Uri.parse('$BASE_URL/saksi/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responsDecode = jsonDecode(responseString);
        SaksiModel saksi = SaksiModel.fromJson(responsDecode['data']);
        return saksi;
      } else {
        print('Gagal mendapatkan detail Saksi: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan saat mendapatkan detail Saksi: $e');
      return null;
    }
  }

  CreateSaksi(String nama, String email, String telephone,
      String provinsi, String kabupaten, String kecamatan,
      String kelurahan, String tps) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(BASE_URL+'/saksi'),);
      request.fields.addAll({
        'name': nama,
        'email': email,
        'telephone': telephone,
        'provinsi': provinsi,
        'kabupatebn': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'tps': tps,
        
      });
    
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
  EditSaksi(int id, String nama, String email, String telephone,
      String provinsi, String kabupaten, String kecamatan,
      String kelurahan, String tps) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$BASE_URL/saksi/$id'),
      );
      request.fields.addAll({
        'name': nama,
        'email': email,
        'telephone': telephone,
        'provinsi': provinsi,
        'kabupatebn': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'tps': tps,
      });
      

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseDecode =
        jsonDecode(responseBody) as Map<String, dynamic>;

        print(id.toString());
        print(request.fields.toString());
        print(responseDecode.toString());
      } else {
        print('Gagal mengedit Saksi: ${response.reasonPhrase}');
        String responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengedit Saksi: $e');
    }
  }
  DeleteSaksi(int id) async {
    try {
      var request = http.Request('DELETE', Uri.parse('$BASE_URL/saksi/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Saksi berhasil dihapus');
        // Hapus saksi dari daftar saksiList
        saksiListan.removeWhere((saksi) => saksi.id == id);
      } else {
        print('Gagal menghapus Saksi: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat menghapus Saksi: $e');
    }
  }
}