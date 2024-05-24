import 'package:flutter/material.dart';

class Koordinator extends StatefulWidget {
  const Koordinator({super.key});

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
          Koordinator2(onItemSelected: _changeIndex),
          Tambah(onBack: () => _changeIndex(0)), // Kembali ke Koordinator
          Detail(onBack: () => _changeIndex(0)), // Kembali ke Koordinator
        ],
      ),
    );
  }
}

class Koordinator2 extends StatelessWidget {
  final ValueChanged<int> onItemSelected;

  const Koordinator2({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
            child: Text('koordinator'),
          ),
          ElevatedButton(
            onPressed: () {
              onItemSelected(1); // Index for "Tambah"
            },
            child: Text('tambah'),
          ),
          ElevatedButton(
            onPressed: () {
              onItemSelected(2); // Index for "Detail"
            },
            child: Text('detail'),
          ),
        ],
      ),
    );
  }
}

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

class Detail extends StatelessWidget {
  final VoidCallback onBack;

  const Detail({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('detail'),
          ElevatedButton(
            onPressed: onBack,
            child: Text('Kembali'),
          ),
        ],
      ),
    );
  }
}
