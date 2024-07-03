import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';

class CreateC1 extends StatefulWidget {
  CreateC1({super.key});

  @override
  State<CreateC1> createState() => _CreateC1State();
}

class _CreateC1State extends State<CreateC1> {
  TextEditingController suaracontroller = TextEditingController();
  File _C1Image = File('');
  String? C1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          textSpan(text: "UPLOAD C1 !", warna: Colors.black),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          loginData.clear();
                          Navigator.pop(context);
                        });
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        size: 35,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    textfield(
                        controller: suaracontroller,
                        obscure: false,
                        label: 'Jumlah Suara'),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pickAnyFile();
                        });
                      },
                      onLongPress: () {
                        _showImageDialog(context, _C1Image);
                      },
                      child: SizedBox(
                        height: 500,
                        width: 350,
                        child: DecoratedBox(
                          child: Center(
                            child: Text(
                              "PILIH FOTO C1",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                  _C1Image,
                                ),
                                fit: BoxFit.cover),
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    fixedSize: Size(180, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  _UploadC1(
                      loginData['userID'], suaracontroller.text, _C1Image);
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAnyFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.first.path!);
      setState(() {
        _C1Image = file;
      });
    } else {
      setState(() {
        _C1Image;
      });
    }
  }

  TextSpan textSpan({
    required String text,
    required Color warna,
  }) {
    return TextSpan(
      text: text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.w900,
        fontSize: 40,
        letterSpacing: 2.6,
        color: warna,
      ),
    );
  }

  void _showImageDialog(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _UploadC1(id, String jumlahsuara, File foto) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$BASE_URL/v2/uploadc1/$id'),
      );
      print(jumlahsuara);
      print(foto.path);

      request.fields.addAll({
        'jumlah_suara': jumlahsuara,
      });
      if (foto.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('foto_kertas_suara', foto.path));
      }

      http.StreamedResponse response = await request.send();

      var responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        CustomSnackBar(context, 'Sukses Upload C1:}', Colors.green);
        print(jsonDecode(responseString));
      } else {
        CustomSnackBar(context, 'Gagal Upload C1: ${response}', Colors.red);
      }
    } catch (e) {
      CustomSnackBar(context, 'Terjadi kesalahan saat Upload: $e', Colors.red);
    }
  }

  void CustomSnackBar(BuildContext context, String message, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: warna,
      ),
    );
  }
}

class textfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  const textfield({
    super.key,
    required this.controller,
    required this.obscure,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 350,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.black12,
          labelText: label,
        ),
      ),
    );
  }
}
