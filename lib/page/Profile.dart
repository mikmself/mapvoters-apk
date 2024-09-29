import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';
import 'package:mapvotersapk/component/model/PaslonModel.dart';
import 'package:mapvotersapk/component/service/KoordinatorService.dart';
import 'package:mapvotersapk/component/service/PaslonService.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';

List<String> type = [
  'gubernur',
  'bupati/walikota',
  'dprri',
  'dprdprov',
  'dprdkab',
  'dpd'
];
List<Map<String, String>> partai = [];
String? partai_id;
String? typeselect;
String? partaiselect;

class ProfilePage extends StatefulWidget {
  final VoidCallback onBack;
  const ProfilePage({Key? key, required this.title, required this.onBack})
      : super(key: key);
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PaslonService service = PaslonService();
  final KoordinatorService koorService = KoordinatorService();
  PaslonModel? paslon;
  KoordinatorModel? Koor;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _partaiController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nomorUrutController = TextEditingController();
  final TextEditingController _dapilController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    profilAktif();
  }

  void profilAktif() {
    if (loginData['role'] == 'paslon') {
      getPaslon();
      fetchPartai();
    } else {
      getKoordinator();
    }
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
          int index = partai.indexWhere(
              (element) => element['nama'] == fetchedPaslon.partai!.nama);
          if (index != -1) {
            partaiselect = partai[index]['nama']; // Perbaikan di sini
            _partaiController.text = partaiselect!;
          }
        }
      });
    }
  }

  Future<void> getKoordinator() async {
    final KoordinatorModel? fetchedKoor =
        await koorService.GetKoordinatorDetail(loginData['userID']);
    if (fetchedKoor != null) {
      setState(() {
        Koor = fetchedKoor;
        _namaController.text = fetchedKoor.user!.name!;
        _emailController.text = fetchedKoor.user!.email!;
        _telephoneController.text = fetchedKoor.user!.telephone!;
        _nomorUrutController.text = fetchedKoor.nik!;
      });
    }
  }

  Future<void> fetchPartai() async {
    final response = await http.get(Uri.parse('$BASE_URL/partai'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        partai = data
            .map((item) => {
                  'nama': item['nama'] as String,
                  'id': item['id'].toString(),
                })
            .toList();
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
        var fileStream =
            http.ByteStream(Stream.castFrom(_imageFile!.openRead()));
        var length = await _imageFile!.length();
        var multipartFile = http.MultipartFile('foto', fileStream, length,
            filename: _imageFile!.path.split('/').last);
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
            children: [
              const SizedBox(height: 50),
              textfield(
                typeinput: TextInputType.text,
                controller: _namaController,
                obscure: false,
                label: 'Nama',
              ),
              const SizedBox(height: 20),
              textfield(
                typeinput: TextInputType.emailAddress,
                controller: _emailController,
                obscure: false,
                label: 'Email',
              ),
              const SizedBox(height: 20),
              textfield(
                typeinput: TextInputType.phone,
                controller: _telephoneController,
                obscure: false,
                label: 'Telephone',
              ),
              if (loginData['role'] == 'paslon') const SizedBox(height: 20),
              if (loginData['role'] == 'paslon')
                dropdown(
                  controller: _partaiController,
                  label: 'Partai',
                  list: partai
                      .map((e) => e['nama']!)
                      .toList(), // Ensure 'nama' values are non-null
                  onSelected: (value) {
                    setState(() {
                      partaiselect = value;
                      _partaiController.text = value!;
                      int index = partai
                          .indexWhere((element) => element['nama'] == value);
                      if (index != -1) {
                        partai_id = partai[index]
                            ['id']; // Retrieve 'id' from the partai map
                      }
                    });
                  },
                ),
              if (loginData['role'] == 'paslon') const SizedBox(height: 20),
              if (loginData['role'] == 'paslon')
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
                typeinput: TextInputType.number,
                controller: _nomorUrutController,
                obscure: false,
                label: loginData['role'] == 'paslon' ? 'Nomor Urut' : 'NIK',
              ),
              if (loginData['role'] == 'paslon') const SizedBox(height: 20),
              if (loginData['role'] == 'paslon')
                textfield(
                  typeinput: TextInputType.text,
                  controller: _dapilController,
                  obscure: false,
                  label: 'Dapil',
                ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onBack,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: const Size(150, 50),
                      ),
                      child: Text(
                        "Kembali",
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                          fontSize: 18,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        loginData['role'] == 'paslon'
                            ? updatePaslon()
                            : koorService.EditKoordinator(
                                loginData['userID'],
                                _namaController.text,
                                _nomorUrutController.text,
                                _emailController.text,
                                _telephoneController.text,
                                "password");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: const Size(150, 50),
                      ),
                      child: Text(
                        "Update",
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
            ],
          ),
        ),
      ),
    );
  }
}
