import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calonpemilih.dart';

class Pemtaansuaraprov extends StatefulWidget {
  const Pemtaansuaraprov({super.key});

  @override
  State<Pemtaansuaraprov> createState() => _PemtaansuaraprovState();
}

class _PemtaansuaraprovState extends State<Pemtaansuaraprov> {
  TextEditingController cariprov = TextEditingController();
  @override
  Widget build(BuildContext context) {
   final   screenWidth = MediaQuery.of(context).size.width;
   final   screenHeight = MediaQuery.of(context).size.height;
    
   
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/gambar/a.jpg'),
          fit: BoxFit.cover,
          )
        ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Text(
                'Provinsi',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Color(0xFF3E3E3E),),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                
                margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
                
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 179, 179, 179),
                  border: Border.all(
                    color: Color.fromARGB(166, 214, 214, 214)
                  ),
                  
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )]
                  
                ),
                child: Padding(
                  
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    
                    controller: cariprov,
                    decoration: InputDecoration(
                      hintText: "Provinsi Yang Di Cari",
                      hintStyle: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      
                      border: InputBorder.none,
                      suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp),iconSize: 30,)
                    ),
                    style: GoogleFonts.getFont('Nunito'),
                    
                  ),
                  
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: screenWidth * 0.9,
                height: screenHeight*0.6,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(children: [
                  _buildInfoContainer('Data')
                ],),
              ),
            )
            ],
          ), 
      ),
      
    );
  }
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
        boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  )]
      ),
      child: SizedBox(
        height: 50, // Menambahkan tinggi untuk memastikan widget bisa terlihat
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible( // Menggunakan Flexible untuk memastikan teks dapat beradaptasi dengan lebar
              child: Text(
                text,
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontSize: 20,
                  color: Color.fromARGB(255, 233, 233, 233),
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis, // Menambahkan overflow agar teks yang panjang dapat dipotong
              ),
            ),
            Container(
              width: 200,
              height: double.infinity, // Mengatur tinggi agar kontainer memiliki tinggi yang sama dengan SizedBox
              decoration: BoxDecoration(
                color: const Color.fromARGB(179, 255, 255, 255),
                borderRadius: BorderRadiusDirectional.circular(5)
              ),
            ),
          ],
        ),
      ),

    );
  }
