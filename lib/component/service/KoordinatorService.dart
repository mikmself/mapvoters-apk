import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';

class KoordinatorService {
  GetAllDataKoordinator() async {
    var request =
    http.Request('GET', Uri.parse(BASE_URL + '/koordinator'));

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
}