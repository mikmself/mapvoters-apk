import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final double leftMargin,
      rightMargin,
      topMargin,
      bottomMargin,
      height,
      width,
      fontSize;
  final Color color;
  final bool isSecure;

  TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.color,
    required this.leftMargin,
    required this.rightMargin,
    required this.topMargin,
    required this.bottomMargin,
    required this.height,
    required this.width,
    required this.fontSize,
    this.isSecure = false,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool secure;

  @override
  void initState() {
    super.initState();
    secure = widget.isSecure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.fromLTRB(widget.leftMargin, widget.topMargin,
          widget.rightMargin, widget.bottomMargin),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: secure,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w700,
                fontSize: widget.fontSize,
                color: Color(0xFF3E3E3E),
              ),
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: widget.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (widget.hintText == "Password")
            IconButton(
              onPressed: () {
                setState(() {
                  secure = !secure;
                });
              },
              icon: Icon(
                secure ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
