import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/controller/SaksiController.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/page/Saksi/RegisterSaksi.dart';
import 'package:mapvotersapk/component/service/SaksiService.dart';

class Saksi extends StatefulWidget {
  const Saksi({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<Saksi> createState() => _SaksiState();
}

class _SaksiState extends State<Saksi> {
  final SaksiService _saksiService = SaksiService();
  int _currentIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

    @override
  void initState() {
    super.initState();
    _refreshSaksiList();
  }

  void _refreshSaksiList() {
    setState(() {
      _saksiService.GetAllDataSaksi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          GetAllDataSaksi(
            refresh: _refreshSaksiList,
            onItemSelected: _changeIndex,
            judul: 'Saksi',
            list: saksiListan,
          ),
          Registersaksi(
            onBack: () => _changeIndex(0),
          ),
        ],
      ),
    );
  }
}
