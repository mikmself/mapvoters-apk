import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';
import 'package:mapvotersapk/component/model/PartaiModel.dart';
import 'package:mapvotersapk/component/model/PemilihModel.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';

class methodRegister {
  registerUser(String nama, String email, String telp, String pass, String type,
      String partai_id, String dapil, String noUrut, File foto) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('https://6392-112-78-156-160.ngrok-free.app/api/paslon'));
      request.fields.addAll({
        'name': nama,
        'email': email,
        'telephone': telp,
        'password': pass,
        'type': 'gubernur',
        'nomor_urut': noUrut,
        'dapil': dapil,
        'partai_id': '1'
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

  registerKoor(String nama, String NIK, String Email, String telp,
      String Password, File foto) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://47.236.54.237/api/koordinator'));
      request.fields.addAll({
        'name': nama,
        'email': Email,
        'telephone': telp,
        'password': Password,
        'nik': NIK,
        'paslon_id': '1'
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

  showsaksi() async {
    var request =
        http.Request('GET', Uri.parse('http://47.236.54.237/api/saksi'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      print(responseString);
      Map<String, dynamic> responsDecode = jsonDecode(responseString);
      List<dynamic> data = responsDecode['data'];
      saksiList.clear();
      for (var element in data) {
        saksiList.add(SaksiModel.fromJson(element));
      }
      print(saksiList.toString());
    } else {
      print(response.reasonPhrase);
    }
  }

  showkoordinator() async {
    var request =
        http.Request('GET', Uri.parse('http://47.236.54.237/api/koordinator'));

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

  showpemilih() async {
    var request = http.Request(
        'GET', Uri.parse('http://47.236.54.237/api/pemilih-potensial'));

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

  Future<List<PartaiModel>> getDataPartaix() async {
    var request =
        http.Request('GET', Uri.parse('http://47.236.54.237/api/partai'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = json.decode(responseString);
      List<dynamic> partaiList = jsonResponse['data'];
      print(partaiList);
      return partaiList
          .map<PartaiModel>((json) => PartaiModel.fromJson(json))
          .toList();
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to load parties');
    }
  }
}
