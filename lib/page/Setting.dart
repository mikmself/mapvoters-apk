import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/SettingModel.dart';
import 'package:mapvotersapk/component/service/SettingService.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final SettingService service = SettingService();
  SettingModel? setting;
  final TextEditingController _targetSuaraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSetting();
  }

  Future<void> getSetting() async {
    final SettingModel? fetchedSetting =
    await service.GetSettingDetail(loginData['paslonID'] as int);
    if (fetchedSetting != null) {
      setState(() {
        setting = fetchedSetting;
        _targetSuaraController.text = fetchedSetting.targetSuara.toString();
      });
    }
  }

  Future<void> updateSetting() async {
    if (setting == null) {
      return;
    }

    String url = BASE_URL + '/pengaturan/${loginData['paslonID']}';

    Map<String, dynamic> requestBody = {
      'targetSuara': int.parse(_targetSuaraController.text),
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        setState(() {
          setting!.targetSuara = int.parse(_targetSuaraController.text);
        });
      } else {
        print('Failed to update setting. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating setting: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _targetSuaraController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Target Suara',
                    labelStyle: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      print(_targetSuaraController.text);
                      updateSetting();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: const Size(200, 50),
                    ),
                    child: Text(
                      "Update Setting",
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
