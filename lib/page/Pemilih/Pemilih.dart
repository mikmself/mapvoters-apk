import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/controller/PemilihController.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/page/Pemilih/Create_Pemilih.dart';

class Pemilih extends StatefulWidget {
  const Pemilih({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;


  @override
  State<Pemilih> createState() => _PemilihState();
}

class _PemilihState extends State<Pemilih> {
  int _currentIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  void _goBack() {
  setState(() {
    _currentIndex = 0;
  });
  }

  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          GetAllDataPemilih(
            onItemSelected: _changeIndex,
            judul: 'pemilih',
            list: pemilihlist,
          ),
          CreatePemilih(
            onBack: () => _changeIndex(0),
          ),
        ],
      ),
    );
  }
}