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



class PemilihService {
  
  GetAllDataPemilih() async {
    var request =
    http.Request('GET', Uri.parse(BASE_URL +'/pemilih-potensial'));

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
      print(pemilihlist.toString());
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
        print('Gagal mendapatkan detail Pemilih: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Terjadi kesalahan saat mendapatkan detail Pemilih: $e');
      return null;
    }
  }

  CreatePemilih(String nama, String nik, File fotoKtp, String telephone, String tps, int provinsiId, int kabupatenId, int kecamatanId, int kelurahanId) async {
    try {
      var request = http.MultipartRequest(
        'POST', Uri.parse(BASE_URL+'/pemilih-potensial'),);
      request.fields.addAll({
        'nama': nama,
        'nik': nik,
        'telephone': telephone,
        'tps': tps,
        'provinsi_id': provinsiId.toString(),
        'kabupaten_id': kabupatenId.toString(),
        'kecamatan_id': kecamatanId.toString(),
        'kelurahan_id': kelurahanId.toString(),
        'kordinator_id': loginData['kordinatorID']!,
      });
      request.files.add(await http.MultipartFile.fromPath('foto_ktp', fotoKtp.path));

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

  EditPemilih(int id, String nama, String nik, File fotoKtp, String telephone, String tps, int provinsiId, int kabupatenId, int kecamatanId, int kelurahanId) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
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
        request.files.add(await http.MultipartFile.fromPath('foto_ktp', fotoKtp.path));
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseDecode = jsonDecode(responseBody) as Map<String, dynamic>;

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
      var request = http.Request('DELETE', Uri.parse('$BASE_URL/pemilih-potensial/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Pemilih berhasil dihapus');
        // Hapus Pemilih dari daftar pemilihlist
        pemilihlist.removeWhere((pemilih) => pemilih.id == id);
      } else {
        print('Gagal menghapus Pemilih: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat menghapus Pemilih: $e');
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
      print(provinsiList[0].id);


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