import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mapvotersapk/page/Register/pageComponent/builderwidget.dart';
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
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/gambar/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 190, 15, 110),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  buildtextfield(
                    hinttext: "Nama",
                    controllerUse: _namacontroller,
                    warna: Colors.black12,
                  ),
                  buildtextfield(
                    hinttext: "Email",
                    controllerUse: _emailcontroller,
                    warna: Colors.black12,
                  ),
                  buildtextfield(
                    hinttext: "Telephone",
                    controllerUse: _noHPcontroller,
                    warna: Colors.black12,
                  ),
                  buildtextfield(
                    hinttext: "Password",
                    controllerUse: _passwordcontroller,
                    warna: Colors.black12,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 340,
                    height: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 90,
                              height: 40,
                              child: Text(
                                "Foto :",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                _pickAnyFile();
                              },
                              child: Container(child: Text("Pilih File")),
                            ),
                          ],
                        ),
                        _imageFile != null
                            ? wadahfoto(
                                foto: _imageFile!,
                              )
                            : Icon(
                                Icons.person,
                                size: 100,
                              )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => nextRegister(
                            nama: _namacontroller.text,
                            email: _emailcontroller.text,
                            noHP: int.parse(_noHPcontroller.text),
                            password: _passwordcontroller.text,
                            foto: _imageFile!,
                          ),
                        ),
                      );
                    },
                    child: Text("Next"),
                  )
                ],
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
            child: Image.file(imageFile),
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: FileImage(foto), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
