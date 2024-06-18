import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _targetSuaraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              textfield(
                controller: _targetSuaraController,
                obscure: false,
                label: 'Target Suara',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
