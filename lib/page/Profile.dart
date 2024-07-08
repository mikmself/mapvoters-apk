import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/PaslonModel.dart';
import 'package:mapvotersapk/component/service/PaslonService.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';

List<String> type = ['gubernur', 'bupati/walikota', 'dprri', 'dprdprov', 'dprdkab', 'dpd'];
List<Map<String, String>> partai = [];
String? partai_id;
String? typeselect;
String? partaiselect;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PaslonService service = PaslonService();
  PaslonModel? paslon;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _partaiController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nomorUrutController = TextEditingController();
  final TextEditingController _dapilController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    fetchData();
    print(partai);
    getPaslon();
  }

  Future<void> getPaslon() async {
    final PaslonModel? fetchedPaslon = await service.GetPaslonDetail();
    if (fetchedPaslon != null) {
      setState(() {
        paslon = fetchedPaslon;
        _namaController.text = fetchedPaslon.user!.name!;
        _emailController.text = fetchedPaslon.user!.email!;
        _telephoneController.text = fetchedPaslon.user!.telephone!;
        _typeController.text = fetchedPaslon.type!;
        _nomorUrutController.text = fetchedPaslon.nomorUrut!;
        _dapilController.text = fetchedPaslon.dapil!;

        if (fetchedPaslon.partai!.nama != null) {
          int index = partai.indexWhere((element) => element['nama'] == fetchedPaslon.partai!.nama);
          if (index != -1) {
            partaiselect = partai[index]['nama']; // Perbaikan di sini
            _partaiController.text = partaiselect!;
          }
        }
      });
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$BASE_URL/partai'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        partai = data.map((item) => {
          'nama': item['nama'] as String,
          'id': item['id'].toString(),
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> updatePaslon() async {
    if (paslon == null) {
      return;
    }

    String url = BASE_URL + '/paslon/${loginData['userID']}';

    try {
      // Prepare JSON data
      Map<String, dynamic> requestBody = {
        'name': _namaController.text,
        'email': _emailController.text,
        'telephone': _telephoneController.text,
        'type': _typeController.text,
        'nomor_urut': _nomorUrutController.text,
        'dapil': _dapilController.text,
        'partai_id': partai_id, // Tambahkan partai_id ke requestBody
      };


      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      requestBody.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (_imageFile != null) {
        var fileStream = http.ByteStream(Stream.castFrom(_imageFile!.openRead()));
        var length = await _imageFile!.length();
        var multipartFile = http.MultipartFile('foto', fileStream, length, filename: _imageFile!.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          paslon!.user!.name = _namaController.text;
          paslon!.user!.email = _emailController.text;
          paslon!.user!.telephone = _telephoneController.text;
          paslon!.type = _typeController.text;
          paslon!.nomorUrut = _nomorUrutController.text;
          paslon!.dapil = _dapilController.text;
          paslon!.partai!.nama = partaiselect;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Paslon updated successfully'),
          ),
        );
      } else {
        print('Failed to update paslon. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating paslon: $e');
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
                list: partai.map((e) => e['nama']!).toList(), // Ensure 'nama' values are non-null
                onSelected: (value) {
                  setState(() {
                    partaiselect = value;
                    _partaiController.text = value!;
                    
                    // Find the ID of the selected partai
                    int index = partai.indexWhere((element) => element['nama'] == value);
                    if (index != -1) {
                      partai_id = partai[index]['id']; // Retrieve 'id' from the partai map
                    }
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
                            image: paslon != null && paslon!.foto != null
                                ? DecorationImage(
                              image: NetworkImage(
                                BASE_URL.replaceFirst('/api', '/${paslon!.foto!}'),
                              ),
                              fit: BoxFit.cover,
                            )
                                : null,
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: paslon != null && paslon!.foto == null
                              ? Center(child: Text('No Image Available')) // Optional: Placeholder text or widget
                              : null,
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
                    _typeController.text = value!;
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
                  updatePaslon();
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

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
