import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/PemilihModel.dart';
import 'package:mapvotersapk/component/service/PemilihService.dart';
import 'package:mapvotersapk/component/sidebar.dart';


PemilihService service = PemilihService();

class GetAllDataPemilih extends StatefulWidget {
  final String judul;
  final List<PemilihModel> list;
  final ValueChanged<int> onItemSelected;

  const GetAllDataPemilih({
  Key? key,
  required this.judul,
  required this.list,
  required this.onItemSelected,
}) : super(key: key);


  @override
  _GetAllDataPemilihState createState() => _GetAllDataPemilihState();
}

class _GetAllDataPemilihState extends State<GetAllDataPemilih> {
  TextEditingController searchController = TextEditingController();
  List<PemilihModel> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = widget.list;
  }

  void _deletePemilih(int id) {
    service.deletePemilih(id);
    setState(() {
      widget.list.removeWhere((pemilih) => pemilih.id == id);
      searchResults.removeWhere((pemilih) => pemilih.id == id);
    });
  }

  void _showPemilihDetailDialog(int id) async {
    PemilihModel? pemilih = await service.getPemilihDetail(id);
    if (pemilih != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detail Pemilih'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                  Image.network(BASE_URL.replaceFirst('/api', '/') + pemilih.fotoKtp!),
                Text('Nama: ${pemilih.nama}'),
                SizedBox(height: 8),
                Text('NIK: ${pemilih.nik}'),
                SizedBox(height: 8),
                Text('Telephone: ${pemilih.telephone}'),
                SizedBox(height: 8),
                Text('Provinsi: ${pemilih.provinsi}'),
                SizedBox(height: 8),
                Text('Kabupaten: ${pemilih.kabupaten}'),
                SizedBox(height: 8),
                Text('Kecamatan: ${pemilih.kecamatan}'),
                SizedBox(height: 8),
                Text('Kelurahan: ${pemilih.kelurahan}'),
                SizedBox(height: 8),
                Text('TPS: ${pemilih.tps}'),
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

void _editPemilih(PemilihModel pemilih) {
  final nameController = TextEditingController(text: pemilih.nama);
  final NIKController = TextEditingController(text: pemilih.nik);
  final phoneController = TextEditingController(text: pemilih.telephone);
  final provinsiIdController = TextEditingController(text: pemilih.provinsi!.id.toString());
  final kabupatenIdController = TextEditingController(text: pemilih.kabupaten!.id.toString());
  final kecamatanIdController = TextEditingController(text: pemilih.kecamatan!.id.toString());
  final kelurahanIdController = TextEditingController(text: pemilih.kelurahan!.id.toString());
  final tpsController = TextEditingController(text: pemilih.tps);
  File? foto_ktp;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Pemilih'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: NIKController,
                decoration: InputDecoration(
                  labelText: 'NIK',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                ),
              ),
              TextField(
                controller: provinsiIdController,
                decoration: InputDecoration(
                  labelText: 'Provinsi',
                ),
              ),
              TextField(
                controller: kabupatenIdController,
                decoration: InputDecoration(
                  labelText: 'Kabupaten',
                ),
              ),
              TextField(
                controller: kecamatanIdController,
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                ),
              ),
              TextField(
                controller: kelurahanIdController,
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
              service.editPemilih(
                pemilih.id!,
                nameController.text,
                NIKController.text,
                foto_ktp ?? File(''),
                tpsController.text,
                phoneController.text,
                int.parse(provinsiIdController.text),
                int.parse(kabupatenIdController.text),
                int.parse(kecamatanIdController.text),
                int.parse(kelurahanIdController.text),
                
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



  void searchList(String query) {
    List<PemilihModel> results = widget.list
        .where((item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      searchResults = results;
    });
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
                controller: searchController,
                onChanged: searchList,
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
                  future: service.getAllDataPemilih(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Terjadi kesalahan: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData || searchResults.isEmpty) {
                      return const Center(
                        child: Text("Data tidak ditemukan"),
                      );
                    }
                    return ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(searchResults[index].nama!),
                                                       trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () {
                                    _showPemilihDetailDialog(searchResults[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editPemilih(searchResults[index]);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deletePemilih(searchResults[index].id!);
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

