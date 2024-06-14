import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      home: CreatePemilih(),
    );
  }
}

class CreatePemilih extends StatefulWidget {
  @override
  _CreatePemilihState createState() => _CreatePemilihState();
}

class _CreatePemilihState extends State<CreatePemilih> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _subdistrictController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _tpsController = TextEditingController();

  File _imageFile = File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 15),
          _buildImagePicker(context),
          const SizedBox(height: 15),
          _buildTextField(_nameController, 'Nama'),
          const SizedBox(height: 15),
          _buildTextField(_nikController, 'NIK'),
          const SizedBox(height: 15),
          _buildTextField(_telephoneController, 'Telephone'),
          const SizedBox(height: 15),
          _buildTextField(_provinceController, 'Provinsi'),
          const SizedBox(height: 15),
          _buildTextField(_districtController, 'Kabupaten'),
          const SizedBox(height: 15),
          _buildTextField(_subdistrictController, 'Kecamatan'),
          const SizedBox(height: 15),
          _buildTextField(_villageController, 'Kelurahan'),
          const SizedBox(height: 15),
          _buildTextField(_tpsController, 'TPS'),
          const SizedBox(height: 5),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Flexible(
      flex: 4,
      child: Container(
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Flexible(
      flex: 8,
      child: Container(
        width: 340,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Flexible(
              flex: 35,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _pickAnyFile();
                  });
                },
                onLongPress: () {
                  _showImageDialog(context, _imageFile);
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _imageFile.path.isEmpty
                                ? AssetImage('assets/placeholder.png')
                                : FileImage(_imageFile) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(),
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        _imageFile.path.isEmpty ? 'Foto KTP' : '',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Flexible(
      flex: 2,
      child: textfield(controller: controller, obscure: false, label: label),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(right: 15),
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black12,
              fixedSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle the form submission
                print('Form submitted');
              }
            },
            child: Text(
              "TAMBAH",
              style: GoogleFonts.getFont(
                'Nunito',
                fontWeight: FontWeight.w900,
                fontSize: 17,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
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
        _imageFile;
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

  Widget textfield(
      {required TextEditingController controller,
      required bool obscure,
      required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.getFont(
            'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color.fromARGB(255, 31, 30, 30),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Color.fromARGB(50, 74, 86, 70),
        ),
        style: GoogleFonts.getFont(
          'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Color.fromARGB(255, 31, 30, 30),
        ),
      ),
    );
  }
}
