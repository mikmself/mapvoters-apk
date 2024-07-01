import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';

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

  // CreateSaksi(String nama, String email, String telephone,
  //     String provinsi, String kabupaten, String kecamatan,
  //     String kelurahan, String tps) async {
  //   try {
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse(BASE_URL+'/saksi'),);
  //     request.fields.addAll({
  //       'name': nama,
  //       'email': email,
  //       'telephone': telephone,
  //       'provinsi': provinsi,
  //       'kabupatebn': kabupaten,
  //       'kecamatan': kecamatan,
  //       'kelurahan': kelurahan,
  //       'tps': tps,
        
  //     });
    
  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

   Future<int?> createUser(String name, String email, String telephone) async {
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + '/user'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'telephone': telephone,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        return responseData['data']['id'];
      } else {
        print('Gagal membuat User: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan saat membuat User: $e');
      return null;
    }
  }

  Future<void> createSaksi(int userId, String provinsi, String kabupaten, String kecamatan, String kelurahan, String tps) async {
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + '/saksi'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'provinsi': provinsi,
          'kabupaten': kabupaten,
          'kecamatan': kecamatan,
          'kelurahan': kelurahan,
          'tps': tps,
        }),
      );

      if (response.statusCode == 200) {
        print('Saksi berhasil dibuat');
      } else {
        print('Gagal membuat Saksi: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat membuat Saksi: $e');
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
  Future<void> showProvinsi() async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/provinsi'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];

      provinsiList.clear();
      for (var element in data) {
        provinsiList.add(ProvinsiModel(id: element['id'], nama: element['nama']));
      }
      print(provinsiList);

      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKab(id) async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/provinsi/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data']['kabupaten'];

      kabupatenList.clear();
      for (var element in data) {
        kabupatenList.add(KabupatenModel(id: element['id'], nama: element['nama']));
      }
      print(kabupatenList[0].id);


    } else {
      print(response.reasonPhrase);
    }
  }
  Future<void> showkecamatan(id) async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/kabupaten/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data']['kecamatan'];

      kecamatanList.clear();
      for (var element in data) {
        kecamatanList.add(KecamatanModel(id: element['id'], nama: element['nama']));
      }
      print(kecamatanList[0].id);


    } else {
      print(response.reasonPhrase);
    }
  }
  Future<void> showkelurahan(id) async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/kecamatan/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data']['kelurahan'];

      kelurahanList.clear();
      for (var element in data) {
        kelurahanList.add(KelurahanModel(id: element['id'], nama: element['nama']));
      }
      print(kelurahanList[0].id);


    } else {
      print(response.reasonPhrase);
    }
  }

  
  
}