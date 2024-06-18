import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';


List<String> type = ["PRESIDEN", "DPR RI", "DPRD PROVINSI"];
List<String> partai = [];
String? typeselect;
String? partaiselect;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _namaController =
  TextEditingController(text: loginData['nama']);
  final TextEditingController _emailController =
  TextEditingController(text: loginData['email']);
  final TextEditingController _telephoneController =
  TextEditingController(text: loginData['telephone']);
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _partaiController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nomorUrutController =
  TextEditingController(text: loginData['nomor_urut']);
  final TextEditingController _dapilController =
  TextEditingController(text: loginData['dapil']);

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$BASE_URL/partai'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        partai = data.map((item) => item['nama'] as String).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

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
              dropdown(
                controller: _partaiController,
                label: 'Partai',
                list: partai,
                onSelected: (value) {
                  setState(() {
                    partaiselect = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: SizedBox(
                  height: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            Text(
                              "FOTO :",
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                letterSpacing: 1,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                                fixedSize: const Size(140, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _pickAnyFile();
                              },
                              child: Text(
                                "PILIH FILE",
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _imageFile != null
                          ? wadahfoto(
                        foto: _imageFile!,
                      )
                          : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 140,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(''),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              dropdown(
                controller: _typeController,
                label: 'Tipe Pemilihan',
                list: type,
                onSelected: (value) {
                  setState(() {
                    typeselect = value;
                  });
                },
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
                onPressed: () {
                  // Implementasi logika untuk tombol Update Profile
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: const Size(200, 50),
                ),
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

  Future<void> _pickAnyFile() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.first.path!);
      setState(() {
        _imageFile = file;
      });
    } else {
      setState(() {
        _imageFile = null;
      });
    }
  }
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

class wadahfoto extends StatelessWidget {
  final File foto;
  const wadahfoto({
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context, foto);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: 140,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: FileImage(foto), fit: BoxFit.cover),
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
