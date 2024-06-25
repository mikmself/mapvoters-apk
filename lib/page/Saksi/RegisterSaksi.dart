import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/service/KoordinatorService.dart';
import 'package:mapvotersapk/page/Register/nextRegister.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mapvotersapk/component/service/SaksiService.dart';

List<String> prov = ["Jawa Tengah", "Jawa Timur", "Jawa Barat"];
List<String> kab = ["Banyumas", "Purbalingga", "Banjarnegara"];
List<String> kec = ["Purwokerto Timur", "Sokaraja", "Purwokerto Barat"];
List<String> kel = ["Sumampir", "Kranji", "Sokanegara"];

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
            dropdown(
                  controller: _provcontroller,
                  label: 'Provinsi',
                  list: prov,
                  onSelected: (value) {
                    setState(() {
                      provselect = value;
                    });
                  },
                ),
            const SizedBox(height: 15),
            dropdown(
                  controller: _kabcontroller,
                  label: 'Kabupaten',
                  list: kab,
                  onSelected: (value) {
                    setState(() {
                      kabselect = value;
                    });
                  },
                ),
            const SizedBox(height: 15),
            dropdown(
                  controller: _keccontroller,
                  label: 'Kecamatan',
                  list: kec,
                  onSelected: (value) {
                    setState(() {
                      kecselect = value;
                    });
                  },
                ),
            const SizedBox(height: 15),
            dropdown(
                  controller: _kelcontroller,
                  label: 'Kelurahan',
                  list: kel,
                  onSelected: (value) {
                    setState(() {
                      kelselect = value;
                    });
                  },
                ),
            const SizedBox(height: 15),
            textfield(
                controller: _tpscontroller,
                obscure: false,
                label: 'TPS'),
            const SizedBox(height: 15),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  SaksiService service = SaksiService();
                  
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
                // onPressed: () {
                //   KoordinatorService service = KoordinatorService();          
                // },
              ),
            
            
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

// void _showImageDialog(BuildContext context, File imageFile) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             child: Image.file(
//               imageFile,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// class FotoContainer extends StatelessWidget {
//   final File foto;
//   const FotoContainer({
//     super.key,
//     required this.foto,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _showImageDialog(context, foto);
//       },
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: 140,
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: FileImage(foto), fit: BoxFit.cover),
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//       ),
//     );
//   }
// }
