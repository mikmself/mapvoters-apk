import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaddingwithTextFieldWidget extends StatelessWidget {
  final String hinttext;
  final TextEditingController controllerUse;
  final double L, R, T, B, tinggi, lebar;
  final Color warna;
  const PaddingwithTextFieldWidget({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(L, T, R, B),
      child: SizedBox(
        width: lebar,
        height: tinggi,
        child: Container(
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              obscureText: obscure(),
              style: GoogleFonts.getFont(
                'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xFFFFFFFF),
              ),
              controller: controllerUse,
              decoration: InputDecoration(
                focusColor: Color(0xFFFFFFFF),
                contentPadding: EdgeInsets.only(),
                border: InputBorder.none,
                hintText: hinttext,
                hintStyle: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
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
