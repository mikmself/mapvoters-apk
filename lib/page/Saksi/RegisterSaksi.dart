import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/component/model/UserMode.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';

class RegisterSaksi extends StatefulWidget {
  final SaksiModel? saksi;
  final Function(SaksiModel)? onSave;
  const RegisterSaksi({super.key, this.saksi, this.onSave});

  @override
  State<RegisterSaksi> createState() => _RegisterSaksiState();
}

class _RegisterSaksiState extends State<RegisterSaksi> {
  TextEditingController namasaksicontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController nohpcontroller = TextEditingController();
  TextEditingController paswordcontorller = TextEditingController();
  TextEditingController provcontroller = TextEditingController();
  TextEditingController kabcontroller = TextEditingController();
  TextEditingController keccontroller = TextEditingController();
  TextEditingController kelcontroller = TextEditingController();
  TextEditingController tpscontroller = TextEditingController();

void initState() {
  super.initState();
  if(widget.saksi != null) {
    namasaksicontroller.text = widget.saksi!.user?.name ?? '';
    emailcontroller.text = widget.saksi!.user?.email ?? '';
    nohpcontroller.text = widget.saksi!.user?.telephone ?? '';
    tpscontroller.text = widget.saksi!.tps ?? '';
    provcontroller.text = widget.saksi!.provinsi?.nama ?? '';
    kabcontroller.text = widget.saksi!.kabupaten?.nama ?? '';
    keccontroller.text = widget.saksi!.kecamatan?.nama ?? '';
    kelcontroller.text = widget.saksi!.kelurahan?.nama ?? '';
  }
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gambar/a.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'REGISTER SAKSI',
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Color(0xFF3E3E3E),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.fromLTRB(11, 10, 0, 0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(123, 113, 255, 220),
                      border:
                          Border.all(color: const Color.fromARGB(166, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 239, 239, 239),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Data Umum',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(11, 25, 11, 0),
                  padding: EdgeInsets.fromLTRB(11, 20, 11, 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 98, 228, 206),
                            Color.fromARGB(164, 124, 196, 255)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0]),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 100, 96, 96)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    children: [
                      _buildInfoContainer("NAMA SAKSI", namasaksicontroller),
                      _buildInfoContainer("EMAIL", emailcontroller),
                      _buildInfoContainer("NO TELPHONE", nohpcontroller),
                      _buildInfoContainer("PASSWORD", paswordcontorller),
                      _buildInfoContainer("PROVINSI", provcontroller),
                      _buildInfoContainer("KABUPATEN", kabcontroller),
                      _buildInfoContainer("KECAMATAN", keccontroller),
                      _buildInfoContainer("KELURAHAN", kelcontroller),
                      _buildInfoContainer("TPS", tpscontroller),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 50, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        SaksiModel newSaksi = SaksiModel(
                          user: UserModel(
                            name: namasaksicontroller.text,
                            email: emailcontroller.text,
                            telephone: nohpcontroller.text,
                          ),
                          tps: tpscontroller.text,
                          provinsi: ProvinsiModel(nama: provcontroller.text), //ini bener nama kan yah?
                          kabupaten: KabupatenModel(nama: kabcontroller.text), //atau harusnya 
                          kecamatan: KecamatanModel(nama: keccontroller.text),
                          kelurahan: KelurahanModel(nama: kelcontroller.text),
                        );
                        Navigator.pop(context, newSaksi);
                      },
                      child: Text(
                        'Tambah',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                        backgroundColor: Color.fromARGB(255, 5, 143, 129),
                        shadowColor: Colors.white,
                        elevation: 5,
                        minimumSize: Size(150, 60),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String text, TextEditingController controller) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5), // Spacer
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.06,
          margin: EdgeInsets.fromLTRB(0, 0, 1, 9),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 210, 210, 210),
            border: Border.all(
              color: Color.fromARGB(255, 114, 120, 120),
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: text,
              labelStyle: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
