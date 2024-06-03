import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';
import 'package:file_picker/file_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _noHPcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/gambar/backgroundb (1).jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              RichText(
                text: TextSpan(
                  children: [
                    textSpan(text: "Register!", warna: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              textfield(
                  controller: _namacontroller, obscure: false, label: 'Nama'),
              const SizedBox(height: 20),
              textfield(
                  controller: _emailcontroller, obscure: false, label: 'Email'),
              const SizedBox(height: 20),
              textfield(
                  controller: _noHPcontroller,
                  obscure: false,
                  label: 'Telephone'),
              const SizedBox(height: 20),
              textfield(
                  controller: _passwordcontroller,
                  obscure: true,
                  label: 'Password'),
              const SizedBox(height: 20),
              SizedBox(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
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
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              setState(() {
                                _pickAnyFile();
                              });
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
                    const SizedBox(width: 70),
                    _imageFile != null
                        ? wadahfoto(
                            foto: _imageFile!,
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: 140,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('')),
                                border: Border.all(),
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login ?",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black12,
                          fixedSize: const Size(130, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => nextRegister(
                              nama: _namacontroller.text,
                              email: _emailcontroller.text,
                              noHP: int.parse(_noHPcontroller.text),
                              password: _passwordcontroller.text,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "NEXT",
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          letterSpacing: 1.1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
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
        _imageFile = file;
      });
    } else {
      setState(() {
        _imageFile = null;
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
        fontSize: 50,
        letterSpacing: 2.6,
        color: warna,
      ),
    );
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
    super.key,
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
