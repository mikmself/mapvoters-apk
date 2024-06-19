import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController controllerUse;
  final double L, R, T, B, tinggi, lebar, fontsize;
  final Color warna;
  const textfield({
    Key? key,
    required this.hinttext,
    required this.controllerUse,
    required this.warna,
    required this.L,
    required this.R,
    required this.T,
    required this.B,
    required this.tinggi,
    required this.lebar,
    required this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.fromLTRB(L, T, R, B),
      child: TextField(
        obscureText: obscure(),
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w700,
          fontSize: fontsize,
          color: Color(0xFF3E3E3E),
        ),
        controller: controllerUse,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: InputBorder.none,
          hintText: hinttext,
          hintStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.w700,
            fontSize: fontsize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  bool obscure() {
    if (hinttext == "Password") {
      return true;
    } else {
      return false;
    }
  }
}
