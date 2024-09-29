import 'package:flutter/material.dart';
import 'package:mapvotersapk/page/FotoPage.dart';
import 'package:mapvotersapk/page/PasswordPage.dart';
import 'package:mapvotersapk/page/Profile.dart';
import 'package:mapvotersapk/page/TargetSuara.dart';
import 'package:mapvotersapk/page/testing.dart';

class Pengaturan extends StatefulWidget {
  final String title;
  const Pengaturan({super.key, required this.title});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
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
          PengaturanController(
            onItemSelected: _changeIndex,
          ),
          ProfilePage(
            title: "Profil",
            onBack: () => _changeIndex(0),
          ),
          FotoPage(
            title: "Foto",
            onBack: () => _changeIndex(0),
          ),
          PasswordPage(
            title: "Password",
            onBack: () => _changeIndex(0),
          ),
          TargetSuaraPage(
            title: "Target Suara",
            onBack: () => _changeIndex(0),
          ),
        ],
      ),
    );
  }
}
