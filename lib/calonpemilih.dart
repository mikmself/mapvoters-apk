import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Calonpemilih extends StatefulWidget {
  const Calonpemilih({super.key});

  @override
  State<Calonpemilih> createState() => _CalonpemilihState();
}

class _CalonpemilihState extends State<Calonpemilih> {
  TextEditingController cariprov = TextEditingController();
  List<String> calonPemilih = [
    'Yusuf Nur Alam',
    'Shubani Charis P',
    'Maria Anggelina Candara K',
    'Muhamad Irga Khoerul M',
    'Dina Ultia Sinurat',
    'Putri Ratna Sari',
    'Dian Arum Dini'
  ];
  List<String> hasilPencarian = [];

  @override
  void initState() {
    super.initState();
    hasilPencarian = calonPemilih; // Awalnya menampilkan semua calon pemilih
  }

  void _cariNama(String query) {
    final hasil = calonPemilih.where((nama) {
      final namaLower = nama.toLowerCase();
      final queryLower = query.toLowerCase();

      return namaLower.contains(queryLower);
    }).toList();

    setState(() {
      hasilPencarian = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                'Calon Pemilih',
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
                margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 179, 179, 179),
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
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cariprov,
                    onChanged: _cariNama,
                    decoration: InputDecoration(
                      hintText: "Nama Yang Ingin Di Cari",
                      hintStyle: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search_sharp, size: 30),
                    ),
                    style: GoogleFonts.getFont('Nunito', fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
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
                  color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: hasilPencarian.length,
                  itemBuilder: (context, index) {
                    return _buildInfoContainer(hasilPencarian[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 1, 9),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 184, 184, 184),
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0),
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
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.getFont(
                'Nunito',
                fontSize: 20,
                color: Color.fromARGB(255, 233, 233, 233),
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.info_outline)),
          ],
        ),
      ),
    );
  }
}
