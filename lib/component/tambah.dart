import 'package:flutter/material.dart';

class Tambah extends StatelessWidget {
  final VoidCallback onBack;

  const Tambah({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('tambah'),
          ElevatedButton(
            onPressed: onBack,
            child: Text('Kembali'),
          ),
        ],
      ),
    );
  }
}
