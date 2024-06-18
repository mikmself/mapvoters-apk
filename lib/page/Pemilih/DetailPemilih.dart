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
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
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
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
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
                          backgroundColor: Color(0xFF00A6A6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Hapus',style: TextStyle(color: Colors.black)),
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
                          backgroundColor: Color(0xFF00A6A6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Edit', style: TextStyle(color: Colors.black)),
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
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black), // Menambahkan garis hitam di sekeliling kotak
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
  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedSubdistrict;
  String? _selectedVillage;
  late TextEditingController _tpsController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _fotoKtp = File(widget.imagePath);
    _isFotoKtpSelected = _fotoKtp.existsSync();
    _nameController = TextEditingController(text: widget.nama);
    _nikController = TextEditingController(text: widget.nik);
    _telephoneController = TextEditingController(text: widget.telephone);
    _selectedProvince = widget.provinsi;
    _selectedDistrict = widget.kabupaten;
    _selectedSubdistrict = widget.kecamatan;
    _selectedVillage = widget.kelurahan;
    _tpsController = TextEditingController(text: widget.tps);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _telephoneController.dispose();
    _tpsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(17.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Detail Data',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              SizedBox(height: 16),
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
              _buildProvinceDropdown(),
              _buildDistrictDropdown(),
              _buildSubdistrictDropdown(),
              _buildVillageDropdown(),
              _buildTextField(_tpsController, 'TPS'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement update logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00A6A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Batal  ', style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Implement cancel logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00A6A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Simpan', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvinceDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Provinsi',
          border: OutlineInputBorder(),
        ),
        value: _selectedProvince,
        onChanged: (newValue) {
          setState(() {
            _selectedProvince = newValue.toString();
          });
        },
        items: <String>['Jawa TENGAH', 'Jawa BARAT', 'Jawa TIMUR', 'DKI Jakarta'] // Isi dengan daftar provinsi yang diinginkan
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDistrictDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Kabupaten',
          border: OutlineInputBorder(),
        ),
        value: _selectedDistrict,
        onChanged: (newValue) {
          setState(() {
            _selectedDistrict = newValue.toString();
          });
        },
        items: <String>['BANYUMAS', 'PURWOKERTO', 'BANJARNEGARA', 'CILACAP'] // Isi dengan daftar kabupaten yang diinginkan
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSubdistrictDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Kecamatan',
          border: OutlineInputBorder(),
        ),
        value: _selectedSubdistrict,
        onChanged: (newValue) {
          setState(() {
            _selectedSubdistrict = newValue.toString();
          });
        },
        items: <String>['PURWOKERTO BARAT', 'PURWOKERTO TIMUR', 'PURWOKERTO SELATAN', 'PURWOKERTO UTARA'] // Isi dengan daftar kecamatan yang diinginkan
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVillageDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Kelurahan',
          border: OutlineInputBorder(),
        ),
        value: _selectedVillage,
        onChanged: (newValue) {
          setState(() {
            _selectedVillage = newValue.toString();
          });
        },
        items: <String>['PASIR KIDUL', 'PASIR WETAN', 'PASIR LOR', 'PASIR KECIL'] // Isi dengan daftar kelurahan yang diinginkan
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap isi $label';
          }
          return null;
        },
      ),
    );
  }
}
