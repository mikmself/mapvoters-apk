import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/controller/KoordinatorController.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/page/Koordinator/RegisterKoordinator.dart';


class Koordinator extends StatefulWidget {
  const Koordinator({
    super.key, required this.title,
  });
  final String title;
  @override
  State<Koordinator> createState() => _KoordinatorState();
}

class _KoordinatorState extends State<Koordinator> {
  int _currentIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          GetAllDataKoordinator(
            onItemSelected: _changeIndex,
            judul: 'Koordinator',
            labeltext: "Pencarian By Nama",
            list: koorList,
          ),
          // ShowData(onBack: () => _changeIndex(0)), // Kembali ke Koordinator
          RegistrasiKoordinator(
              onBack: () => _changeIndex(0)), // Kembali ke Koordinator
        ],
      ),
    );
  }
}

