import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';




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

  File? _imageFile;

  String? _selectedProvinsi;
  String? _selectedKabupaten;
  String? _selectedKecamatan;
  String? _selectedKelurahan;

  final List<String> _provinsiList = ['Jawa Tengah', 'Jawa Barat', 'Jawa Timur'];
  final Map<String, List<String>> _kabupatenMap = {
    'Jawa Tengah': ['Banyumas', 'Cilacap', 'Purbalingga'],
    'Jawa Barat': ['Bandung', 'Bekasi', 'Bogor'],
    'Jawa Timur': ['Surabaya', 'Malang', 'Jember'],
  };
  final Map<String, List<String>> _kecamatanMap = {
    'Banyumas': ['Purwokerto Barat', 'Purwokerto Timur', 'Purwokerto Utara'],
    'Cilacap': ['Cilacap Selatan', 'Cilacap Tengah', 'Cilacap Utara'],
    'Purbalingga': ['Purbalingga Barat', 'Purbalingga Selatan', 'Purbalingga Timur'],
  };
  final Map<String, List<String>> _kelurahanMap = {
    'Purwokerto Barat': ['Pasir Kidul', 'Pasir Kulon', 'Pasir Lor'],
    'Purwokerto Timur': ['Purwokerto Kidul', 'Purwokerto Tengah', 'Purwokerto Lor'],
    'Purwokerto Utara': ['Purwokerto Wetan', 'Purwokerto Dalem', 'Purwokerto Girang'],
  };

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
              _buildTextField(_nameController, 'Nama'),
              const SizedBox(height: 15),
              _buildTextField(_nikController, 'NIK'),
              const SizedBox(height: 15),
              _buildTextField(_telephoneController, 'Telepon'),
              const SizedBox(height: 15),
              _buildDropdownField(
                label: 'Provinsi',
                value: _selectedProvinsi,
                items: _provinsiList,
                onChanged: (value) {
                  setState(() {
                    _selectedProvinsi = value;
                    _selectedKabupaten = null;
                    _selectedKecamatan = null;
                    _selectedKelurahan = null;
                  });
                },
              ),
              const SizedBox(height: 15),
              if (_selectedProvinsi != null)
                _buildDropdownField(
                  label: 'Kabupaten',
                  value: _selectedKabupaten,
                  items: _kabupatenMap[_selectedProvinsi!]!,
                  onChanged: (value) {
                    setState(() {
                      _selectedKabupaten = value;
                      _selectedKecamatan = null;
                      _selectedKelurahan = null;
                    });
                  },
                ),
              const SizedBox(height: 15),
              if (_selectedKabupaten != null)
                _buildDropdownField(
                  label: 'Kecamatan',
                  value: _selectedKecamatan,
                  items: _kecamatanMap[_selectedKabupaten!]!,
                  onChanged: (value) {
                    setState(() {
                      _selectedKecamatan = value;
                      _selectedKelurahan = null;
                    });
                  },
                ),
              const SizedBox(height: 15),
              if (_selectedKecamatan != null)
                _buildDropdownField(
                  label: 'Kelurahan',
                  value: _selectedKelurahan,
                  items: _kelurahanMap[_selectedKecamatan!]!,
                  onChanged: (value) {
                    setState(() {
                      _selectedKelurahan = value;
                    });
                  },
                ),
              const SizedBox(height: 15),
              _buildTextField(_tpsController, 'TPS'),
              const SizedBox(height: 15),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [textSpan(text: "CalonPemilih", warna: Colors.black)],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              widget.onBack(); 
            },
          ),
        ],
      ),
    );
  }

 Widget _buildImagePicker(BuildContext context) {
  return Container(
    width: 340,
    padding: EdgeInsets.only(left: 15), // Tambahkan padding kiri
    child: GestureDetector(
      onTap: () {
        _pickImage();
      },
      child:Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _imageFile != null
                ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Text(
                      'Pilih Foto KTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
          ),
        
      ),
    );
}


  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
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

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imageFile = File(result.files.first.path!);
      });
    }
  }

  TextSpan textSpan({required String text, required Color warna}) {
    return TextSpan(
      text: text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.w900,
                fontSize: 30,
        letterSpacing: 2.6,
        color: warna,
      ),
    );
  }
}

