import 'package:flutter/material.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('tambah'),
      ),
    );
  }
}
