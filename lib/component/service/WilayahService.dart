import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WilayahService {
  Future<void> showProv() async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/provinsi'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data'];

      provinsiList.clear();
      for (var element in data) {
        provinsiList.add(ProvinsiModel.fromJson(element));
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
        kabupatenList.add(KabupatenModel.fromJson(element));
      }
      print(kabupatenList);

      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKec(id) async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/kabupaten/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data']['kecamatan'];

      kecamatanList.clear();
      for (var element in data) {
        kecamatanList.add(KecamatanModel.fromJson(element));
      }
      print(kecamatanList);

      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> showKel(id) async {
    var request = http.Request('GET', Uri.parse(BASE_URL + '/kecamatan/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

      Map<String, dynamic> responseData = jsonDecode(responseString);
      List<dynamic> data = responseData['data']['kelurahan'];

      kelurahanList.clear();
      for (var element in data) {
        kelurahanList.add(KelurahanModel.fromJson(element));
      }
      print(kelurahanList);

      print(responseData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }
}
