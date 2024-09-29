import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';

class PengaturanController extends StatefulWidget {
  final ValueChanged<int> onItemSelected;

  const PengaturanController({
    super.key,
    required this.onItemSelected,
  });

  @override
  State<PengaturanController> createState() => _PengaturanControllerState();
}

class _PengaturanControllerState extends State<PengaturanController> {
  late List<String> _PageName;
  List<int> _Pageindex = [1, 2, 3, 4];
  @override
  void initState() {
    super.initState();
    _PageName = [
      'Profil',
      'Foto',
      'Password',
      if (loginData['role'] != 'koordinator') 'Target Suara',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: _PageName.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            widget.onItemSelected(_Pageindex[index]);
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black45)),
            margin: EdgeInsets.only(top: 8, right: 10, left: 10),
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _PageName[index],
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
