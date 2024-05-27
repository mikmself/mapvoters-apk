import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mapvotersapk/Regiser/builderwidget.dart';
import 'package:mapvotersapk/modelregister.dart';

List<String> type = ["PRESIDEN", "DPR RI", "DPRD PROVINSI"];
List<String> partai = ["PDIP", "GERINDRA", "PKS"];
String? typeselect;
String? partaiselect;

class nextRegister extends StatefulWidget {
  final String? nama;
  final String? email;
  final int? noHP;
  final String password;
  final File? foto;
  const nextRegister(
      {super.key,
      required this.nama,
      required this.email,
      required this.noHP,
      required this.password,
      required this.foto});

  @override
  State<nextRegister> createState() => _nextRegisterState();
}

class _nextRegisterState extends State<nextRegister> {
  TextEditingController _typecontroller = TextEditingController();
  TextEditingController _noUrutcontroller = TextEditingController();
  TextEditingController _Dapilcontroller = TextEditingController();
  TextEditingController _partaicontroller = TextEditingController();

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
                  builddropdown(
                    hinttext: "Type",
                    list: type,
                    metod: (value) {
                      setState(() {
                        typeselect = value;
                      });
                    },
                    controllerUse: _typecontroller,
                    warna: Colors.black12,
                  ),
                  buildtextfield(
                    hinttext: "No Urut",
                    controllerUse: _noUrutcontroller,
                    warna: Colors.black12,
                  ),
                  buildtextfield(
                    hinttext: "Dapil",
                    controllerUse: _Dapilcontroller,
                    warna: Colors.black12,
                  ),
                  builddropdown(
                      hinttext: "Partai",
                      controllerUse: _partaicontroller,
                      list: partai,
                      metod: (value) {
                        setState(() {
                          partaiselect = value;
                        });
                      },
                      warna: Colors.black12),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          RegistrasiModel daftar = RegistrasiModel(
                              context,
                              widget.nama!,
                              widget.email!,
                              widget.noHP!,
                              widget.password,
                              _typecontroller.text,
                              int.parse(_noUrutcontroller.text),
                              _Dapilcontroller.text,
                              _partaicontroller.text);
                          if (daftar.isValid()) {
                            registrasi.add(daftar);
                          }
                        });
                      },
                      child: Text("DAFTAR")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
