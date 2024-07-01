import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mapvotersapk/component/controller/PemilihController.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CreatePemilih extends StatefulWidget {
  final VoidCallback onBack;
  const CreatePemilih({super.key, required this.onBack});

  @override
  _CreatePemilihState createState() => _CreatePemilihState();
}

class _CreatePemilihState extends State<CreatePemilih> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _tpsController = TextEditingController();

  File foto_ktp= File('');
  String? _selectedProvinsi;
  String? _selectedKabupaten;
  String? _selectedKecamatan;
  String? _selectedKelurahan;


  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, left: 15),
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [textSpan(text: "Pemilih", warna: Colors.black)],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.onBack,
              
          ),
        ],
      ),
    );
  }

   Widget _buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0,),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02, left:15),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12,
      ),
      width: 330,
      height: 60,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 15),
              _buildImagePicker(context),
              const SizedBox(height: 15),
              _buildContainer(_buildTextField(_nameController, 'Nama')),
              _buildContainer(_buildTextField(_nikController, 'NIK')),
              _buildContainer(_buildTextField(_telephoneController, 'Telepon')),
              _buildContainer(
                FutureBuilder(
                  future: service.showProvinsi(),
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Provinsi',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: provinsiList
                            .map((ProvinsiModel provinsi) => DropdownMenuItem(
                                  value: provinsi.id.toString(),
                                  enabled: true,
                                  child: Text(
                                    provinsi.nama.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: _selectedProvinsi,
                        onChanged: (value) {
                          setState(() {
                            _selectedProvinsi = value;
                            print(_selectedProvinsi);
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildContainer(
                FutureBuilder(
                  future: service.showKab(_selectedProvinsi),
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Kabupaten',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: kabupatenList
                            .map((KabupatenModel kabupaten) => DropdownMenuItem(
                                  value: kabupaten.id.toString(),
                                  enabled: true,
                                  child: Text(
                                    kabupaten.nama.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: _selectedKabupaten,
                        onChanged: (value) {
                          setState(() {
                            _selectedKabupaten = value;
                            print(_selectedKabupaten);
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildContainer(
                FutureBuilder(
                  future: service.showkecamatan(_selectedKabupaten),
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Kecamatan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: kecamatanList
                            .map((KecamatanModel kecamatan) => DropdownMenuItem(
                                  value: kecamatan.id.toString(),
                                  enabled: true,
                                  child: Text(
                                    kecamatan.nama.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: _selectedKecamatan,
                        onChanged: (value) {
                          setState(() {
                            _selectedKecamatan = value;
                            print(_selectedKecamatan);
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildContainer(
                FutureBuilder(
                  future: service.showkelurahan(_selectedKecamatan),
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Kelurahan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: kelurahanList
                            .map((KelurahanModel kelurahan) => DropdownMenuItem(
                                  value: kelurahan.id.toString(),
                                  enabled: true,
                                  child: Text(
                                    kelurahan.nama.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: _selectedKelurahan,
                        onChanged: (value) {
                          setState(() {
                            _selectedKelurahan = value;
                            print(_selectedKelurahan);
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildContainer(_buildTextField(_tpsController, 'TPS')),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Container(
      width: 340,
      padding: EdgeInsets.only(left: 15), 
      child: GestureDetector(
        onTap: () {
          _pickImage();
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: foto_ktp.path.isEmpty
            ? Center(
                child: Text(
                  'Pilih Foto KTP',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Image.file(
                foto_ktp,
                fit: BoxFit.cover,
              ),
      ),
    ),
  );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: InputBorder.none,
      ),
    );
  }

void _pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );

  if (result != null && result.files.isNotEmpty) {
    setState(() {
      foto_ktp = File(result.files.single.path!);
    });
  } else {
    
    print('No image selected');
    foto_ktp = File('');
  }
}


  Widget _buildSubmitButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: 150,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Handle form submission
              print('Form submitted');
            }
          },
          child: Text('TAMBAH'),
        ),
      ),
    );
  }

  TextSpan textSpan({required String text, required Color warna}) {
    return TextSpan(
      text: text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: warna,
        ),
      ),
    );
  }
}