import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/page/PemetaanSuara/model/ListModel.dart';
import 'package:mapvotersapk/page/PemetaanSuara/model/modelKabupaten.dart';
import 'package:mapvotersapk/page/PemetaanSuara/model/modelKecamatan.dart';
import 'package:mapvotersapk/page/PemetaanSuara/model/modelKelurahan.dart';
import 'package:mapvotersapk/page/PemetaanSuara/model/modelProvinsi.dart';

class PemetaanSuaraService {
  Future<void> showProvinsi(id) async {
    try {
      var request = http.Request(
          'GET', Uri.parse(BASE_URL + '/pemetaanSuara-provinsi/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        provinsiList.clear();
        for (var element in data) {
          provinsiList.add(modelProvinsi.fromJson(element));
        }

        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> showKabupaten(idProvinsi, id) async {
    try {
      var request = http.Request('GET',
          Uri.parse(BASE_URL + '/pemetaanSuara-kabupaten/$idProvinsi/$id'));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kabupatenList.clear();
        for (var element in data) {
          kabupatenList.add(modelKabupaten.fromJson(element));
        }
        print(kabupatenList[0]);
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

   Future<void> showKecamatan(idKabupaten, id) async {
    try {
      var request = http.Request('GET',
          Uri.parse(BASE_URL + '/pemetaanSuara-kecamatan/$idKabupaten/$id'));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kecamatanList.clear();
        for (var element in data) {
          kecamatanList.add(modelKecamatan.fromJson(element));
        }
        print(kecamatanList[0]);
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> showKelurahan(idKecamatan, id) async {
    try {
      var request = http.Request('GET',
          Uri.parse(BASE_URL + '/pemetaanSuara-kelurahan/$idKecamatan/$id'));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kelurahanList.clear();
        for (var element in data) {
          kelurahanList.add(modelKelurahan.fromJson(element));
        }
        print(kelurahanList[0]);
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }
}