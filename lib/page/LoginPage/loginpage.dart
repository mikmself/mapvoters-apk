import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/LoginPage/pageComponent/builderbutton.dart';
import 'package:mapvotersapk/page/LoginPage/pageComponent/buildertextfield.dart';
import 'package:mapvotersapk/page/LoginPage/pageComponent/LoginService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/page/PemetaanC1/CreateC1.dart';
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
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.425,
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
                    BuilderTextfield(
                      controller: _emailcontroller,
                      color: Color(0x75005E73),
                      hinttext: 'Email',
                      secure: false,
                    ),
                    BuilderTextfield(
                      controller: _paswwordcontroller,
                      color: Color(0x7300A6A6),
                      hinttext: 'Password',
                      secure: true,
                    ),
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
                            metod: () async {
                              LoginService login = LoginService();
                              if (_emailcontroller.text == '' ||
                                  _paswwordcontroller.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Email atau Password Tidak Boleh Kosong!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(
                                        child: CircularProgressIndicator()),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                                bool loginsukses = await login.auth(
                                    _emailcontroller.text,
                                    _paswwordcontroller.text,
                                    context);

                                if (loginsukses) {
                                  _emailcontroller.text = '';
                                  _paswwordcontroller.text = '';
                                  loginData.containsValue('saksi')
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CreateC1()))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SidebarApp()));
                                }
                              }
                            },
                          ),
                          buildbutton(
                            context: context,
                            hinttext: "Sign Up",
                            warnatombol: Colors.white,
                            warnatext: const Color(0x75005E73),
                            metod: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            ),
                          )
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
