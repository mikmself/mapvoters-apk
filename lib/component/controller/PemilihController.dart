import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/PemilihModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/service/PemilihService.dart';
import 'package:mapvotersapk/component/service/WilayahService.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

PemilihService service = PemilihService();
WilayahService WilService = WilayahService();

class GetAllDataPemilih extends StatefulWidget {
  final String judul;
  final List<PemilihModel> list;
  final ValueChanged<int> onItemSelected;

  const GetAllDataPemilih({
    super.key,
    required this.judul,
    required this.list,
    required this.onItemSelected,
  });

  @override
  _GetAllDataPemilihState createState() => _GetAllDataPemilihState();
}

class _GetAllDataPemilihState extends State<GetAllDataPemilih> {
  TextEditingController searchController = TextEditingController();
  List<PemilihModel> searchResults = [];
  String? provinsi_id;

  @override
  void initState() {
    super.initState();
    searchResults = widget.list;
  }

  Widget _buildContainer(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.02, left: 15),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12,
      ),
      width: 330,
      height: 60,
      child: child,
    );
  }

  void _deletePemilih(int id) {
    service.DeletePemilih(id);
    setState(() {
      widget.list.removeWhere((pemilih) => pemilih.id == id);
      searchResults.removeWhere((pemilih) => pemilih.id == id);
    });
  }

  void _showPemilihDetailDialog(int id) async {
    PemilihModel? pemilih = await service.GetPemilihDetail(id);
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
                Image.network(
                    BASE_URL.replaceFirst('/api', '/') + pemilih.fotoKtp!),
                Text('Nama: ${pemilih.nama}'),
                SizedBox(height: 8),
                Text('NIK: ${pemilih.nik}'),
                SizedBox(height: 8),
                Text('Telephone: ${pemilih.telephone}'),
                SizedBox(height: 8),
                Text('Provinsi: ${pemilih.provinsi!.nama}'),
                SizedBox(height: 8),
                Text('Kabupaten: ${pemilih.kabupaten!.nama}'),
                SizedBox(height: 8),
                Text('Kecamatan: ${pemilih.kecamatan!.nama}'),
                SizedBox(height: 8),
                Text('Kelurahan: ${pemilih.kelurahan!.nama}'),
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

  void _editPemilih(id) async {
    
    PemilihModel? pemilih = await service.GetPemilihDetail(id);
    
    final nameController = TextEditingController(text: pemilih!.nama);
    final NIKController = TextEditingController(text: pemilih.nik);
    final phoneController = TextEditingController(text: pemilih.telephone);
    String? _provSelected;
    String? _kabSelected ;
    String? _kecSelected ;
    String? _kelSelected ;


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
                Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 60,
                        width: 350,
                        child: FutureBuilder(
                          future: WilService.showProv(),
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Provinsi',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: provinsiList
                                    .map((ProvinsiModel provinsi) =>
                                        DropdownMenuItem(
                                          value: provinsi.id.toString(),
                                          enabled: true,
                                          child: Text(
                                            provinsi.nama.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: _provSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _provSelected = value;
                                    kabupatenList.clear();
                                    kecamatanList.clear();
                                    kelurahanList.clear();
                                    _kabSelected = null;
                                    _kecSelected = null;
                                    _kelSelected = null;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 60,
                        width: 350,
                        child: FutureBuilder(
                          future: WilService.showKab(_provSelected),
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Kabupaten',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: kabupatenList
                                    .map((KabupatenModel kabupaten) =>
                                        DropdownMenuItem(
                                          value: kabupaten.id.toString(),
                                          enabled: true,
                                          child: Text(
                                            kabupaten.nama!
                                                .toUpperCase()
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: _kabSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _kabSelected = value;
                                    kecamatanList.clear();
                                    kelurahanList.clear();
                                    _kecSelected = null;
                                    _kelSelected = null;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 60,
                        width: 350,
                        
                        child: FutureBuilder(
                          future: WilService.showKec(_kabSelected),
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Kecamatan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: kecamatanList
                                    .map((KecamatanModel kecamatan) =>
                                        DropdownMenuItem(
                                          value: kecamatan.id.toString(),
                                          enabled: true,
                                          child: Text(
                                            kecamatan.nama!
                                                .toUpperCase()
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: _kecSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _kecSelected = value;
                                    kelurahanList.clear();
                                    _kelSelected = null;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 60,
                        width: 350,
                        child: FutureBuilder(
                          future: WilService.showKel(_kecSelected),
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Kelurahan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: kelurahanList
                                    .map((KelurahanModel kelurahan) =>
                                        DropdownMenuItem(
                                          value: kelurahan.id.toString(),
                                          enabled: true,
                                          child: Text(
                                            kelurahan.nama!
                                                .toUpperCase()
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: _kelSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _kelSelected = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  TextField(
                  controller: tpsController,
                  decoration: InputDecoration(
                    labelText: 'tps',
                  ),
                ),
              ],
            ),
          ),
          
          actions: [
            TextButton(
              onPressed: () {
                nameController.text = '';
                NIKController.text = '';
                foto_ktp = File('');
                tpsController.text = '';
                phoneController.text = '';
                _provSelected = '';
                _kabSelected = '';
                _kecSelected = '';
                _kelSelected = '';
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                service.EditPemilih(
                  pemilih.id!,
                  nameController.text,
                  NIKController.text,
                  foto_ktp ?? File(''),
                  tpsController.text,
                  phoneController.text,
                  int.parse(_provSelected!),
                  int.parse(_kabSelected!),
                  int.parse(_kecSelected!),
                  int.parse(_kelSelected!),
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
                  future: service.GetAllDataPemilih(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (searchResults.isEmpty) {
                        return const Center(
                          child: Text("data tidak ditemukan"),
                        );
                      }
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
                                    _showPemilihDetailDialog(
                                        searchResults[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editPemilih(searchResults[index].id);
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
