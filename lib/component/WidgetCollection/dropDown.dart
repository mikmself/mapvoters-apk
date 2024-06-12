import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropdownMenu extends StatelessWidget {
  final List<String> field;
  final ValueChanged<String?> onSelected;
  final String hint;
  final double L, T, R, B;

  final TextEditingController controllerUse;

  MyDropdownMenu({
    required this.field,
    required this.onSelected,
    required this.hint,
    required this.controllerUse,
    required this.L,
    required this.T,
    required this.R,
    required this.B,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(L, T, R, B),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: DropdownMenu<String>(
        controller: controllerUse,
        width: MediaQuery.of(context).size.width,
        hintText: hint,
        textStyle: GoogleFonts.getFont(
          'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.black87,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10, bottom: 5),
        ),
        requestFocusOnTap: false,
        onSelected: onSelected,
        dropdownMenuEntries:
            field.map<DropdownMenuEntry<String>>((String item) {
          return DropdownMenuEntry<String>(
            value: item,
            label: item,
          );
        }).toList(),
      ),
    );
  }
}
