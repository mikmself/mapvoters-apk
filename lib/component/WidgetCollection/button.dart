import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class button extends StatelessWidget {
  final VoidCallback metod;
  final double L, R, T, B, lebar, tinggi;
  final String hinttext;
  final Color warnatombol;

  final Color warnatext;
  const button({
    super.key,
    required this.L,
    required this.R,
    required this.T,
    required this.B,
    required this.lebar,
    required this.tinggi,
    required this.hinttext,
    required this.warnatombol,
    required this.warnatext,
    required this.metod,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.fromLTRB(L, T, R, B),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: warnatombol, // Warna latar belakang
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: metod,
          child: Text(hinttext,
              style: GoogleFonts.getFont(
                'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 22.5,
                color: warnatext,
              )),
        ),
      ),
    );
  }
}
