import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textfieldsearch extends StatelessWidget {
  final String alamat;
  final TextEditingController controllerUse;
  final VoidCallback onPressed;

  const textfieldsearch({
    required this.alamat,
    required this.controllerUse,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerUse,
      decoration: InputDecoration(
        hintText: alamat,
        hintStyle: GoogleFonts.getFont(
          'Nunito',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.search_sharp),
          iconSize: 20,
        ),
      ),
      style: GoogleFonts.getFont('Nunito'),
    );
  }
}
