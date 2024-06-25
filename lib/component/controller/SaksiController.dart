import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/component/service/SaksiService.dart';
import 'package:mapvotersapk/component/sidebar.dart';

SaksiService service = SaksiService();

class GetAllDataSaksi extends StatefulWidget {
  final String judul;
  final List list;
  final ValueChanged<int> onItemSelected;

  const GetAllDataSaksi({
    super.key,
    required this.judul,
    required this.list,
    required this.onItemSelected,
  });

  @override
  _GetAllDataSaksiState createState() => _GetAllDataSaksiState();
}

class _GetAllDataSaksiState extends State<GetAllDataSaksi> {
  void _deleteSaksi(int id) {
    service.DeleteSaksi(id);
    setState(() {
      widget.list.removeWhere((saksi) => saksi.id == id);
    });
  }
  void _showSaksiDetailDialog(int id) async {
    SaksiModel? saksi = await service.GetSaksiDetail(id);
    if (saksi != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detail Saksi'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Text('Nama: ${saksi.user!.name}'),
                SizedBox(height: 8),                
                Text('Email: ${saksi.user!.email}'),
                SizedBox(height: 8),
                Text('No Telephone: ${saksi.user!.telephone}'),
                SizedBox(height: 8),
                Text('Provinsi: ${saksi.provinsi!.nama}'),
                SizedBox(height: 8),
                Text('Kabupaten: ${saksi.kabupaten!.nama}'),
                SizedBox(height: 8),
                Text('Kecamatan: ${saksi.kecamatan!.nama}'),
                SizedBox(height: 8),
                Text('Kelurahan: ${saksi.kelurahan!.nama}'),
                SizedBox(height: 8),
                Text('TPS: ${saksi.tps}'),
                
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }
  void _editSaksi(SaksiModel saksi) {
    final nameController = TextEditingController(text: saksi.user!.name);
    final emailController = TextEditingController(text: saksi.user!.email);
    final telephoneController = TextEditingController(text: saksi.user!.telephone);
    final provController = TextEditingController(text: saksi.provinsi!.nama);
    final kabController = TextEditingController(text: saksi.kabupaten!.nama);
    final kecController = TextEditingController(text: saksi.kecamatan!.nama);
    final kelController = TextEditingController(text: saksi.kelurahan!.nama);
    final tpsController = TextEditingController(text: saksi.tps);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Saksi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: telephoneController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                ),
              ),
              TextField(
                controller: provController,
                decoration: InputDecoration(
                  labelText: 'Provinsi',
                ),
              ),
              TextField(
                controller: kabController,
                decoration: InputDecoration(
                  labelText: 'Kabupaten',
                ),
              ),
              TextField(
                controller: kecController,
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                ),
              ),
              TextField(
                controller: kelController,
                decoration: InputDecoration(
                  labelText: 'Kelurahan',
                ),
              ),
              TextField(
                controller: tpsController,
                decoration: InputDecoration(
                  labelText: 'TPS',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                service.EditSaksi(
                  saksi.id!,
                  nameController.text,
                  emailController.text,
                  telephoneController.text,
                  provController.text,
                  kabController.text,
                  kecController.text,
                  kelController.text,
                  tpsController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.judul,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        )),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SidebarApp(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Pencarian By Nama",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: service.GetAllDataSaksi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (widget.list.length == 0) {
                        return const Center(
                          child: Text("data tidak ditemukaxn"),
                        );
                      }
                    }
                    return ListView.builder(
                      itemCount: widget.list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(widget.list[index].user!.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () {
                                    _showSaksiDetailDialog(widget.list[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editSaksi(widget.list[index]);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteSaksi(widget.list[index].id!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                widget.onItemSelected(1);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
