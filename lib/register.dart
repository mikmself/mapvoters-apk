import 'package:flutter/material.dart';
import 'package:mapvotersapk/WidgetCollection/textfieldwithpadding.dart';
import 'package:mapvotersapk/nextRegister.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _noHPcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/gambar/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(3, 195, 3, 0),
              height: MediaQuery.of(context).size.height,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    PaddingwithTextFieldWidget(
                      hinttext: "Nama",
                      controllerUse: _namacontroller,
                      warna: Colors.black12,
                      L: 15,
                      R: 15,
                      T: 20,
                      B: 0,
                      lebar: 350,
                      tinggi: 60,
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: "Email",
                      controllerUse: _emailcontroller,
                      warna: Colors.black12,
                      L: 15,
                      R: 15,
                      T: 20,
                      B: 0,
                      lebar: 350,
                      tinggi: 60,
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: "Telephone",
                      controllerUse: _noHPcontroller,
                      warna: Colors.black12,
                      L: 15,
                      R: 15,
                      T: 20,
                      B: 0,
                      lebar: 350,
                      tinggi: 60,
                    ),
                    PaddingwithTextFieldWidget(
                      hinttext: "Password",
                      controllerUse: _passwordcontroller,
                      warna: Colors.black12,
                      L: 15,
                      R: 15,
                      T: 20,
                      B: 0,
                      lebar: 350,
                      tinggi: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: 340,
                        height: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 90,
                                  height: 40,
                                  child: Text(
                                    "Foto :",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(100),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {},
                                  child: Container(child: Text("Pilih File")),
                                ),
                              ],
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://www.kemhan.go.id/wp-content/uploads/2019/10/tmp_6644-20191028_142938-770056681.jpg"),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => nextRegister(
                                  nama: _namacontroller.text,
                                  email: _emailcontroller.text,
                                  noHP: int.parse(_noHPcontroller.text),
                                  password: _passwordcontroller.text),
                            ),
                          );
                        },
                        child: Text("Next"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
