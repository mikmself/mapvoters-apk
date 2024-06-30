import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Pemetaansuara extends StatefulWidget {
  const Pemetaansuara({super.key, required String title});

  @override
  State<Pemetaansuara> createState() => _PemetaansuaraState();
}

class _PemetaansuaraState extends State<Pemetaansuara> {
  

  @override
  Widget build(BuildContext context) {
    String judul = "Provinsi";
    TextEditingController cariWilayah = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(judul,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ), TextField(controller: cariWilayah,
        decoration: 
        InputDecoration(
           labelText: 'Cari $judul',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                )
        ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          decoration: BoxDecoration(
          color: Color.fromARGB(255, 219, 255, 255),
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(8),
        ),child: SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Jawa TEngah",
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                width: 80,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 113, 255, 220),
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                child: Center(
                  child: Text(
                    "2333",
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        )
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemetaan Suara App',
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home: Pemetaansuara(title: 'Pemetaan Suara'),
    );
  }
}