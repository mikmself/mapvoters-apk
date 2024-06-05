import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/Register/metod.dart';
import 'package:mapvotersapk/page/Register/pageComponent/builderwidget.dart';

List<String> type = ["PRESIDEN", "DPR RI", "DPRD PROVINSI"];
List<String> partai = ["PDIP", "GERINDRA", "PKS"];
String? typeselect;
String? partaiselect;

class nextRegister extends StatefulWidget {
  final String? nama;
  final String? email;
  final int? noHP;
  final String password;

  const nextRegister({
    super.key,
    required this.nama,
    required this.email,
    required this.noHP,
    required this.password,
  });

  @override
  State<nextRegister> createState() => _nextRegisterState();
}

class _nextRegisterState extends State<nextRegister> {
  final TextEditingController _typecontroller = TextEditingController();
  final TextEditingController _noUrutcontroller = TextEditingController();
  final TextEditingController _dapilcontroller = TextEditingController();
  final TextEditingController _partaicontroller = TextEditingController();

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
                  controller: _noUrutcontroller,
                  obscure: false,
                  label: 'No Urut'),
              const SizedBox(height: 20),
              textfield(
                  controller: _dapilcontroller, obscure: false, label: 'Dapil'),
              const SizedBox(
                height: 20,
              ),
              dropdown(
                controller: _partaicontroller,
                label: 'Partai',
                list: partai,
                onSelected: (value) {
                  setState(() {
                    typeselect = value;
                  });
                },
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () {},
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
  const textfield({
    super.key,
    required this.controller,
    required this.obscure,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 350,
      child: TextField(
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
