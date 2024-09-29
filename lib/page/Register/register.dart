import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  File _imageFile = File('');

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
        child: Column(
          children: [
            Flexible(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        textSpan(text: "Register!", warna: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: textfield(
                  typeinput: TextInputType.text,
                  controller: _namacontroller,
                  obscure: false,
                  label: 'Nama'),
            ),
            const SizedBox(height: 15),
            Flexible(
              flex: 2,
              child: textfield(
                  typeinput: TextInputType.emailAddress,
                  controller: _emailcontroller,
                  obscure: false,
                  label: 'Email'),
            ),
            const SizedBox(height: 15),
            Flexible(
              flex: 2,
              child: textfield(
                  typeinput: TextInputType.phone,
                  controller: _noHPcontroller,
                  obscure: false,
                  label: 'Telephone'),
            ),
            const SizedBox(height: 15),
            Flexible(
              flex: 2,
              child: textfield(
                  typeinput: TextInputType.text,
                  controller: _passwordcontroller,
                  obscure: true,
                  label: 'Password'),
            ),
            const SizedBox(height: 15),
            Flexible(
              flex: 5,
              child: Container(
                width: 350,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _pickAnyFile();
                          });
                        },
                        onLongPress: () {
                          _showImageDialog(context, _imageFile);
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(
                                    _imageFile,
                                  ),
                                  fit: BoxFit.cover),
                              border: Border.all(),
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                          // color: Colors.amber,
                          width: MediaQuery.of(context).size.width),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              if (_namacontroller.text == '' ||
                                  _emailcontroller.text == '' ||
                                  _noHPcontroller.text == '' ||
                                  _passwordcontroller.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Lengkapi Data!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => nextRegister(
                                      nama: _namacontroller.text,
                                      email: _emailcontroller.text,
                                      noHP: _noHPcontroller.text,
                                      password: _passwordcontroller.text,
                                      foto: _imageFile,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "NEXT",
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                                letterSpacing: 3,
                                color: Colors.white,
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
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: 350,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sudah Punya Akun? Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
