import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/TPSModel.dart';

class Service {
  Future<void> showProvinsi(id) async {
    var request =
        http.Request('GET', Uri.parse(BASE_URL + '/pemetaan-c1-provinsi/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];

      provinsiList.clear();
      for (var element in data) {
        provinsiList
            .add(ProvinsiModel(id: element['id'], nama: element['nama']));
      }
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKab(idprov, id) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/pemetaan-c1-kabupaten/$idprov/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];
      kabupatenList.clear();
      for (var element in data) {
        kabupatenList.add(KabupatenModel(
          id: element['id'],
          nama: element['nama'],
        ));
      }
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKec(idkab, id) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/pemetaan-c1-kecamatan/$idkab/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];
      kecamatanList.clear();
      for (var element in data) {
        kecamatanList.add(KecamatanModel(
          id: element['id'],
          nama: element['nama'],
        ));
      }
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKel(idkec, id) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/pemetaan-c1-kelurahan/$idkec/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];
      kelurahanList.clear();
      for (var element in data) {
        kelurahanList.add(KelurahanModel(
          id: element['id'],
          nama: element['nama'],
        ));
      }
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showTPS(id, kelurahanId) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/pemetaan-c1-TPS/$kelurahanId/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];
      TPSlist.clear();
      for (var element in data) {
        TPSlist.add(TPSModel(
          tps: element['tps'],
          jumlahSuara: element['jumlah_suara'],
          fotoKertasSuara: element['foto_kertas_suara'],
        ));
      }
      print(data);
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }
}
