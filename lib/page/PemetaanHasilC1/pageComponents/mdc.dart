import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildInfoContainer(String text, VoidCallback onPressed) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 1, 9),
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      color: Color.fromARGB(164, 214, 214, 214),
      border: Border.all(
        color: Color.fromARGB(255, 150, 150, 150),
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 122, 122, 122).withOpacity(0.5),
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
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
    ),
  );
}