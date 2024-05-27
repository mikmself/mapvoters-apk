import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class Ihome extends StatefulWidget {
  const Ihome({super.key});

  @override
  State<Ihome> createState() => _IhomeState();
}

class _IhomeState extends State<Ihome> {
  TextEditingController carinama = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

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
                'CALON PEMILIH',
                // style: GoogleFonts.getFont(
                //   'Nunito',
                //   fontWeight: FontWeight.w900,
                //   fontSize: 30,
                //   color: Color(0xFF3E3E3E),
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                
                margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
                
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 105, 214, 187),
                  border: Border.all(
                    color: const Color.fromARGB(166, 0, 0, 0)
                  ),
                  
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )]
                  
                ),
                child: Padding(
                  
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    
                    controller: carinama,
                    decoration: InputDecoration(
                      hintText: "MASUKAN NAMA",
                      // hintStyle: GoogleFonts.getFont(
                      //   'Nunito',
                      //   fontSize: 20,
                      //   color: Colors.white,
                      //   fontWeight: FontWeight.w900,
                      // ),
                      
                      border: InputBorder.none,
                      suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp),iconSize: 30,)
                    ),
                    // style: GoogleFonts.getFont('Nunito'),
                    
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
                  gradient: LinearGradient(colors: [Color.fromARGB(255, 98, 228, 206),Color.fromARGB(164, 124, 196, 255)],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0,1.0]),
                  boxShadow: [BoxShadow(
                    color: const Color.fromARGB(255, 100, 96, 96).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )]
                ),
                child: Column(
                  children: [
                    _buildInfoContainer("inout data"),
                    _buildInfoContainer("inout data"),
                    _buildInfoContainer("inout data"),
                    _buildInfoContainer("input data"),
                    _buildInfoContainer("input data"),
                    _buildInfoContainer("input data"),
                    _buildInfoContainer("input data"),
                    _buildInfoContainer("input data"),
                    _buildInfoContainer("input data"),
                    _buildInfoContainer("input data"),
                  ],
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
      padding: EdgeInsets.fromLTRB(10, 10, 2, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 187, 187, 187),
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )]
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
            // style: GoogleFonts.getFont('Nunito',fontSize: 20,color: Color.fromARGB(255, 233, 233, 233),fontWeight: FontWeight.w700)
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.info_outline)),
          ],
        ),
      ),
    );
  }
}
