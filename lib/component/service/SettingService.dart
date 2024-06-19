import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/SettingModel.dart';

class SettingService{
  Future<SettingModel?> GetSettingDetail(int id) async {
    try {
      var request = http.Request('GET', Uri.parse('$BASE_URL/pengaturan/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responsDecode = jsonDecode(responseString);
        if (responsDecode.containsKey('data')) {
          return SettingModel.fromJson(responsDecode['data']);
        } else {
          print('Invalid JSON response structure: $responseString');
          return null;
        }
      } else {
        print('Failed to fetch dashboard details: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Error fetching dashboard details: $e');
      return null;
    }
  }
}