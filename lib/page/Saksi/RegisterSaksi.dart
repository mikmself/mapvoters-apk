import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/controller/SaksiController.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';
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
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _noHPcontroller = TextEditingController();
  TextEditingController _tpscontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Future<List<ProvinsiModel>>? _provinsiFuture;
  Future<List<KabupatenModel>>? _kabupatenFuture;
  Future<List<KecamatanModel>>? _kecamatanFuture;
  Future<List<KelurahanModel>>? _kelurahanFuture;

  @override
  void initState() {
    super.initState();
    _provinsiFuture = service.showProvinsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            textfield(
                typeinput: TextInputType.text,
                controller: _namacontroller,
                obscure: false,
                label: 'Nama'),
            const SizedBox(height: 15),
            textfield(
                typeinput: TextInputType.emailAddress,
                controller: _emailcontroller,
                obscure: false,
                label: 'Email'),
            const SizedBox(height: 15),
            textfield(
                typeinput: TextInputType.phone,
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
              child: FutureBuilder<List<ProvinsiModel>>(
                future: _provinsiFuture,
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
                          kabupatenList.clear();
                          kecamatanList.clear();
                          kelurahanList.clear();
                          kabselect = null;
                          kecselect = null;
                          kelselect = null;
                          _kabupatenFuture = service.showKab(provselect);
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
                future: _kabupatenFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
                          kecamatanList.clear();
                          kelurahanList.clear();
                          kecselect = null;
                          kelselect = null;
                          _kecamatanFuture = service.showkecamatan(kabselect);
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
                future: _kecamatanFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
                          kelurahanList.clear();
                          kelselect = null;
                          _kelurahanFuture = service.showkelurahan(kecselect);
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
                future: _kelurahanFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
              typeinput: TextInputType.number,
              controller: _tpscontroller,
              obscure: false,
              label: 'TPS',
            ),
            const SizedBox(height: 15),
            textfield(
                typeinput: TextInputType.text,
                controller: _passwordcontroller,
                obscure: true,
                label: 'Password'),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String nama = _namacontroller.text;
                    String email = _emailcontroller.text;
                    String telephone = _noHPcontroller.text;
                    String tps = _tpscontroller.text;
                    String password = _passwordcontroller.text;
                    if (nama == '' ||
                        email == '' ||
                        telephone == '' ||
                        tps == '' ||
                        password == '' ||
                        provselect == null ||
                        kabselect == null ||
                        kecselect == null ||
                        kelselect == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Lengkapi Data Dulu")));
                    } else {
                      bool createSukses = await service.createSaksi(
                          provselect!,
                          kabselect!,
                          kecselect!,
                          kelselect!,
                          tps,
                          nama,
                          email,
                          telephone,
                          password,
                          context);
                      if (createSukses) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("sukses")));
                        _namacontroller.text = '';
                        _emailcontroller.text = '';
                        _noHPcontroller.text = '';
                        _tpscontroller.text = '';
                        _passwordcontroller.text = '';
                        // setState(() {
                        //   provselect = null;
                        //   kabselect = null;
                        //   kecselect = null;
                        //   kelselect = null;
                        // });
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
            ),
            const SizedBox(height: 30),
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
