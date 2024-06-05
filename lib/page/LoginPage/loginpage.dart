import 'package:flutter/material.dart';
import 'package:mapvotersapk/page/LoginPage/pageComponent/builderbutton.dart';
import 'package:mapvotersapk/page/LoginPage/pageComponent/buildertextfield.dart';
import 'package:mapvotersapk/page/LoginPage/pageComponent/Controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/Register/register.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _paswwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/gambar/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //padding: EdgeInsets.only(right: 30, left: 30),
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% dari lebar layar
                height: MediaQuery.of(context).size.height *
                    0.425, // 50% dari tinggi layar
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFFF2F0F0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: Color(0x6B000000),
                      offset: Offset(0, 10),
                      blurRadius: 9.5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            textSpan(
                                text: "Log", warna: const Color(0xFF87D2D0)),
                            textSpan(
                                text: " In!", warna: const Color(0xFF3E3E3E))
                          ],
                        ),
                      ),
                    ),
                    buildtextfield(
                        hinttext: "Email",
                        controllerUse: _emailcontroller,
                        warna: Color(0x75005E73)),
                    buildtextfield(
                        hinttext: "Password",
                        controllerUse: _paswwordcontroller,
                        warna: Color(0x7300A6A6)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 27),
                      width: 350,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildbutton(
                              context: context,
                              hinttext: "Sign In",
                              warnatombol: const Color(0x75005E73),
                              warnatext: Colors.white,
                              metod: () {
                                LoginController().auth(_emailcontroller.text,
                                    _paswwordcontroller.text);
                              }),
                          buildbutton(
                              context: context,
                              hinttext: "Sign Up",
                              warnatombol: Colors.white,
                              warnatext: const Color(0x75005E73),
                              metod: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  )))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan textSpan({
    required String text,
    required Color warna,
  }) {
    return TextSpan(
      text: text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.w900,
        fontSize: 64,
        letterSpacing: 2.6,
        color: warna,
      ),
    );
  }
}
