import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/PartaiModel.dart';
import 'package:mapvotersapk/component/service/PaslonService.dart';

List<String> type = [
  'gubernur',
  'bupati/walikota',
  'dprri',
  'dprdprov',
  'dprdkab',
  'dpd'
];

String? typeselect;
String? partaiselect;

class nextRegister extends StatefulWidget {
  final String nama;
  final String email;
  final String noHP;
  final String password;
  final File foto;

  const nextRegister({
    super.key,
    required this.nama,
    required this.email,
    required this.noHP,
    required this.password,
    required this.foto,
  });

  @override
  State<nextRegister> createState() => _nextRegisterState();
}

class _nextRegisterState extends State<nextRegister> {
  PaslonService _service = PaslonService();
  final TextEditingController _typecontroller = TextEditingController();
  final TextEditingController _noUrutcontroller = TextEditingController();
  final TextEditingController _dapilcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/gambar/backgroundb.jpg"),
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
              dropdown(
                controller: _typecontroller,
                label: 'Tipe Pemilihan',
                list: type,
                onSelected: (value) {
                  setState(() {
                    typeselect = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              textfield(
                  typeinput: TextInputType.number,
                  controller: _noUrutcontroller,
                  obscure: false,
                  label: 'No Urut'),
              const SizedBox(height: 20),
              textfield(
                  typeinput: TextInputType.text,
                  controller: _dapilcontroller,
                  obscure: false,
                  label: 'Dapil'),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 60,
                width: 350,
                child: FutureBuilder(
                  future: _service.showPartai(),
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Partai',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: partailist
                            .map((PartaiModel partai) => DropdownMenuItem(
                                  value: partai.id.toString(),
                                  enabled: true,
                                  child: Text(
                                    partai.nama.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: partaiselect,
                        onChanged: (value) {
                          setState(() {
                            partaiselect = value;
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
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_typecontroller.text == '' ||
                      partaiselect! == '' ||
                      _dapilcontroller.text == '' ||
                      _noUrutcontroller.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lengkapi Data!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    bool regissukses = await _service.registerPaslon(
                        widget.nama,
                        widget.email,
                        widget.noHP,
                        widget.password,
                        _typecontroller.text,
                        partaiselect!,
                        _dapilcontroller.text,
                        _noUrutcontroller.text,
                        widget.foto,
                        context);
                    if (regissukses) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Register Succesfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(130, 50)),
                child: Text(
                  "DAFTAR",
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
      ),
    );
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

class textfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType typeinput;
  const textfield({
    super.key,
    required this.controller,
    required this.obscure,
    required this.label,
    required this.typeinput,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      height: 60,
      width: 350,
      child: TextField(
        keyboardType: typeinput,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.black12,
          labelText: label,
        ),
      ),
    );
  }
}

class dropdown extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<String> list;
  final ValueChanged<String?> onSelected;
  const dropdown({
    super.key,
    required this.controller,
    required this.label,
    required this.list,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: DropdownMenu<String>(
        label: Text(label),
        controller: controller,
        width: 350,
        requestFocusOnTap: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.black12,
        ),
        onSelected: onSelected,
        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>(
          (String item) {
            return DropdownMenuEntry<String>(
              value: item,
              label: item,
            );
          },
        ).toList(),
      ),
    );
  }
}
