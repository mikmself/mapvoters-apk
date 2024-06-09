import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';

List<String> type = ["PRESIDEN", "DPR RI", "DPRD PROVINSI"];
List<String> partai = ["PDIP", "GERINDRA", "PKS"];
String? typeselect;
String? partaiselect;

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _partaiController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nomorUrutController = TextEditingController();
  final TextEditingController _dapilController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              textfield(
                controller: _namaController,
                obscure: false,
                label: 'Nama',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _emailController,
                obscure: false,
                label: 'Email',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _telephoneController,
                obscure: false,
                label: 'Telephone',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _newPasswordController,
                obscure: true,
                label: 'New Password',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _partaiController,
                obscure: false,
                label: 'Partai',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _fotoController,
                obscure: false,
                label: 'Foto',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _typeController,
                obscure: false,
                label: 'Type',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _nomorUrutController,
                obscure: false,
                label: 'Nomor Urut',
              ),
              const SizedBox(height: 20),
              textfield(
                controller: _dapilController,
                obscure: false,
                label: 'Dapil',
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(200, 50)),
                child: Text(
                  "Update Profile",
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
