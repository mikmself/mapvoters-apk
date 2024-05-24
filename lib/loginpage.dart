import 'package:flutter/material.dart';
import 'package:mapvotersapk/WidgetCollection/textfieldwithpadding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/register.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _paswwordcontroller = TextEditingController();
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFF2F0F0),
                    boxShadow: [
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w900,
                              fontSize: 64,
                              letterSpacing: 2.6,
                              color: Color(0xFF3E3E3E),
                            ),
                            children: [
                              TextSpan(
                                text: 'Log',
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 64,
                                  height: 1.3,
                                  letterSpacing: 2.6,
                                  color: Color(0xFF87D2D0),
                                ),
                              ),
                              TextSpan(
                                text: ' In!',
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 64,
                                  letterSpacing: 2.6,
                                  color: Color(0xFF3E3E3E),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PaddingwithTextFieldWidget(
                          hinttext: "Email",
                          controllerUse: _emailcontroller,
                          warna: Color(0x75005E73),
                          L: 0,
                          T: 40,
                          R: 40,
                          B: 0,
                          lebar: 350,
                          tinggi: 50,
                        ),
                        PaddingwithTextFieldWidget(
                          hinttext: "Password",
                          controllerUse: _paswwordcontroller,
                          warna: Color(0x7300A6A6),
                          L: 0,
                          T: 20,
                          R: 40,
                          B: 0,
                          lebar: 350,
                          tinggi: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Sign In")),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Register(),
                                                ),
                                              );
                                            },
                                            child: Text("Sign Up")))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
