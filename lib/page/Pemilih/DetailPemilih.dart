import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailPemilih(),
    );
  }
}

class DetailPemilih extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detail Data',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back), // Mengubah ikon menjadi panah kembali
                         onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 20,
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 160,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('FOTO KTP'),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildContainerWithText('NAMA', 'YUSUF NUR ALAM'),
                   _buildContainerWithText('NIK', '3302298738928392'),
                  _buildContainerWithText('TELEPHONE', '082782324829'),
                  _buildContainerWithText('PROVINSI', 'Jawa TENGAH'),
                  _buildContainerWithText('KABUPATEN', 'BANYUMAS'),
                  _buildContainerWithText('KECAMATAN', 'PURWOKERTO BARAT'),
                  _buildContainerWithText('KELURAHAN', 'PASIR KIDUL'),
                  _buildContainerWithText('TPS', '08'),
                  SizedBox(height: 8), // Tambah jarak sebelum tombol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle delete action
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Hapus'),
                      ),
                      SizedBox(width: 10), // Tambah jarak antara tombol
                      ElevatedButton(
                        onPressed: () {
                          // Handle update action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePemilih(
                                imagePath: 'path_to_image',
                                nama: 'YUSUF NUR ALAM',
                                nik: '3302298738928392',
                                telephone: '082782324829',
                                provinsi: 'Jawa TENGAH',
                                kabupaten: 'BANYUMAS',
                                kecamatan: 'PURWOKERTO BARAT',
                                kelurahan: 'PASIR KIDUL',
                                tps: '08',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerWithText(String labelText, String value) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Ubah warna sesuai dengan warna foto KTP
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}

class UpdatePemilih extends StatefulWidget {
  final String imagePath;
  final String nama;
  final String nik;
  final String telephone;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kelurahan;
  final String tps;

  UpdatePemilih({
    required this.imagePath,
    required this.nama,
    required this.nik,
    required this.telephone,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
    required this.tps,
  });

  @override
  _UpdatePemilihState createState() => _UpdatePemilihState();
}

class _UpdatePemilihState extends State<UpdatePemilih> {
  late File _fotoKtp; 
  bool _isFotoKtpSelected = false;
  late TextEditingController _nameController;
  late TextEditingController _nikController;
  late TextEditingController _telephoneController;
  late TextEditingController _provinceController;
  late TextEditingController _districtController;
  late TextEditingController _subdistrictController;
  late TextEditingController _villageController;
  late TextEditingController _tpsController;

  @override
  void initState() {
    super.initState();
    _fotoKtp = File(widget.imagePath);
    _isFotoKtpSelected = _fotoKtp.existsSync();
    _nameController = TextEditingController(text: widget.nama);
    _nikController = TextEditingController(text: widget.nik);
    _telephoneController = TextEditingController(text: widget.telephone);
    _provinceController = TextEditingController(text: widget.provinsi);
    _districtController = TextEditingController(text: widget.kabupaten);
    _subdistrictController = TextEditingController(text: widget.kecamatan);
    _villageController = TextEditingController(text: widget.kelurahan);
    _tpsController = TextEditingController(text: widget.tps);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _telephoneController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _subdistrictController.dispose();
    _villageController.dispose();
    _tpsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _fotoKtp.path.isEmpty
                          ? AssetImage('assets/placeholder.png')
                          : FileImage(_fotoKtp) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                if (_isFotoKtpSelected)
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          _isFotoKtpSelected = false;
                           _fotoKtp = File('');
                        });
                      },   
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                        if (result != null) {
                          setState(() {
                            _fotoKtp = File(result.files.first.path!);
                            _isFotoKtpSelected = true;
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          _isFotoKtpSelected ? 'Ganti Foto KTP' : 'Pilih Foto KTP Baru',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _buildTextField(_nameController, 'Nama'),
            _buildTextField(_nikController, 'NIK'),
            _buildTextField(_telephoneController, 'Telephone'),
            _buildTextField(_provinceController, 'Provinsi'),
            _buildTextField(_districtController, 'Kabupaten'),
            _buildTextField(_subdistrictController, 'Kecamatan'),
            _buildTextField(_villageController, 'Kelurahan'),
            _buildTextField(_tpsController, 'TPS'),
            ElevatedButton(
              onPressed: () {
                // Implement update logic here
                Navigator.pop(context);
              },
              child: Text('  Edit  '),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
