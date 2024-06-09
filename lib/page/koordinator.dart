import 'package:flutter/material.dart';

class Koordinator extends StatefulWidget {
  const Koordinator({super.key, required this.title});
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.grey,
              alignment: Alignment.center,
              child: Text('PAGE KOORDINATOR'),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onItemSelected(1); // Index for "Tambah"
                  },
                  child: Text('Tambah'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onItemSelected(2); // Index for "Detail"
                  },
                  child: Text('Detail'),
                ),
              ],
            )
          ],
        ),
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tambah Koordinator'),
            ElevatedButton(
              onPressed: onBack,
              child: Text('Kembali'),
            ),
          ],
        ),
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detail  Koordinator'),
            ElevatedButton(
              onPressed: onBack,
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
