import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/controller/SaksiController.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/service/KoordinatorService.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mapvotersapk/component/service/SaksiService.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

String? provselect;
String? kabselect;
String? kecselect;
String? kelselect;

class Registersaksi extends StatefulWidget {
  final VoidCallback onBack;
  const Registersaksi({super.key, required this.onBack});
  @override
  State<Registersaksi> createState() => _RegisterState();
}
class _RegisterState extends State<Registersaksi> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _noHPcontroller = TextEditingController();
  TextEditingController _provcontroller = TextEditingController();
  TextEditingController _kabcontroller = TextEditingController();
  TextEditingController _keccontroller = TextEditingController();
  TextEditingController _kelcontroller = TextEditingController();
  TextEditingController _tpscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              
              width: 350,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        textSpan(text: "Registrasi Saksi", warna: Colors.black),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: widget.onBack,
                  ),
                ],
              ),
            ),
            textfield(
                controller: _namacontroller, obscure: false, label: 'Nama'),
            const SizedBox(height: 15),
            textfield(
                controller: _emailcontroller, obscure: false, label: 'Email'),
            const SizedBox(height: 15),
            textfield(
                controller: _noHPcontroller,
                obscure: false,
                label: 'Telephone'),
            const SizedBox(height: 15),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 60,
                width: 350,
                child: FutureBuilder(
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
                        value: provselect,
                        onChanged: (value) {
                          setState(() {
                            provselect = value;
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
            const SizedBox(height: 15),
                Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 60,
                width: 350,
                child: FutureBuilder(
                  future: service.showKab(provselect),
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
                        value: kabselect,
                        onChanged: (value) {
                          setState(() {
                            kabselect = value;
                            print(kabselect);
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
            const SizedBox(height: 15),
                Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 60,
                width: 350,
                child: FutureBuilder(
                  future: service.showkecamatan(kabselect),
                  builder: (context, snapshot) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'kecamatan',
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
                        value: kecselect,
                        onChanged: (value) {
                          setState(() {
                            kecselect = value;
                            print(kecselect);
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
            const SizedBox(height: 15),
                Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 60,
                width: 350,
                child: FutureBuilder(
                  future: service.showkelurahan(kecselect),
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
                        value: kelselect,
                        onChanged: (value) {
                          setState(() {
                            kelselect = value;
                            print(kelselect);
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
            const SizedBox(height: 15),
            textfield(
                controller: _tpscontroller,
                obscure: false,
                label: 'TPS'),
            const SizedBox(height: 15),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       // Handle the form submission
                  //       print('Form submitted');
                  //     }
                  //   },
                  //   child: Text('Tambah'),
                  //   style: ElevatedButton.styleFrom(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Handle the form submission
                        String nama = _namacontroller.text;
                        String email = _emailcontroller.text;
                        String telephone = _noHPcontroller.text;
                        String tps = _tpscontroller.text;

                        // Buat user baru
                        int? userId = await service.createUser(nama, email, telephone);
                        
                        if (userId != null) {
                          // Buat saksi dengan user_id yang baru dibuat
                          await service.createSaksi(
                            userId,
                            provselect!,
                            kabselect!,
                            kecselect!,
                            kelselect!,
                            tps,
                          );
                          // Reset form setelah berhasil menambahkan
                          _namacontroller.clear();
                          _emailcontroller.clear();
                          _noHPcontroller.clear();
                          _tpscontroller.clear();
                          setState(() {
                            provselect = null;
                            kabselect = null;
                            kecselect = null;
                            kelselect = null;
                          });
                        } else {
                          // Jika gagal membuat user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal membuat user')),
                          );
                        }
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
                )                      
          ],
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
        fontSize: 30,
        letterSpacing: 2.6,
        color: warna,
      ),
    );
  }
}
