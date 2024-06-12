import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';

class Service {
  Future<void> showProvinsi() async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/get-provinsi'));

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

  Future<void> showKab(id) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/get-kabupaten-provinsi/$id'));

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

  Future<void> showKec(id) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/get-kecamatan-kabupaten/$id'));

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
      print(responseData['data']);
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKel(id) async {
    var request = http.Request(
        'GET', Uri.parse(BASE_URL + '/get-kelurahan-kecamatan/$id'));
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
      print(responseData['data']);
      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }
}
