import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/PemetaanHasilC1/pageComponents/mdc.dart';
import 'package:mapvotersapk/page/PemetaanHasilC1/pageComponents/txtf.dart';

class RIC1 extends StatefulWidget {
  const RIC1({super.key});

  @override
  State<RIC1> createState() => _ProvC1State();
}

class _ProvC1State extends State<RIC1> {
  TextEditingController cariri = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: screenHeight, // Mengatur tinggi kontainer sesuai tinggi layar
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
                  'PEMETAAN -C1',
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    color: Color(0xFF3E3E3E),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(164, 214, 214, 214),
                    border: Border.all(
                      color: Color.fromARGB(166, 214, 214, 214),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textfieldsearch(
                      alamat: 'RI',
                      controllerUse: cariri,
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.6,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 105, 186, 192).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      buildInfoContainer('text', () { })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
