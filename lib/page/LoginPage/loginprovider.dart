import 'package:get/get.dart';

class Loginprovider extends GetConnect {
  Future<Response> auth(var data) {
    var myHeaders = {'Accept': 'application/json'};

    return post(
      'https://dummyjson.com/products/',
      data, /*headers: myHeaders*/
    );
  }
}
