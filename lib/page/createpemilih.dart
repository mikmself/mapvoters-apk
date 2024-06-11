import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 237, 237),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Data',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    SizedBox(height: 8), // Mengurangi jarak di sini
                    Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey[300],
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle KTP upload
                          },
                          child: const Text('PILIH FOTO KTP'),
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Mengurangi jarak di sini
                    PaddingwithTextFieldWidget(
                      hinttext: 'NAMA',
                      controllerUse: _nameController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'NIK',
                      controllerUse: _nikController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'TELEPHONE',
                      controllerUse: _telephoneController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'PROVINSI',
                      controllerUse: _provinceController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'KABUPATEN',
                      controllerUse: _districtController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'KECAMATAN',
                      controllerUse: _subdistrictController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'KELURAHAN',
                      controllerUse: _villageController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: 'TPS',
                      controllerUse: _tpsController,
                      warna: Color.fromARGB(50, 74, 86, 70),
                      L: 5,
                      R: 5,
                      T: 5, // Jarak antar kotak lebih kecil
                      B: 5, // Jarak antar kotak lebih kecil
                      tinggi: 40, // Ukuran lebih kecil
                      lebar: 300, // Ukuran lebih kecil
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Kembali'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle the form submission
                        print('Form submitted');
                      }
                    },
                    child: Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaddingwithTextFieldWidget extends StatelessWidget {
  final String hinttext;
  final TextEditingController controllerUse;
  final double L, R, T, B, tinggi, lebar;
  final Color warna;
  const PaddingwithTextFieldWidget({
    Key? key,
    required this.hinttext,
    required this.controllerUse,
    required this.warna,
    required this.L,
    required this.R,
    required this.T,
    required this.B,
    required this.tinggi,
    required this.lebar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(L, T, R, B),
      child: SizedBox(
        width: lebar,
        height: tinggi,
        child: Container(
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              obscureText: hinttext == "Password",
              style: GoogleFonts.getFont(
                'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color.fromARGB(255, 31, 30, 30),
              ),
              controller: controllerUse,
              decoration: InputDecoration(
                focusColor: Color(0xFFFFFFFF),
                contentPadding: EdgeInsets.only(),
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}