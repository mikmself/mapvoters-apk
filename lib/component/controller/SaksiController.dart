import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/component/service/SaksiService.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/Saksi/saksi.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';

String? provselect;
String? kabselect;
String? kecselect;
String? kelselect;

SaksiService service = SaksiService();

class GetAllDataSaksi extends StatefulWidget {
  final String judul;
  final List list;
  final ValueChanged<int> onItemSelected;
  final Function refresh;

  const GetAllDataSaksi({
    super.key,
    required this.judul,
    required this.list,
    required this.onItemSelected,
    required this.refresh,
  });

  @override
  _GetAllDataSaksiState createState() => _GetAllDataSaksiState();
}

class _GetAllDataSaksiState extends State<GetAllDataSaksi> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = widget.list;
  }

  void _deleteSaksi(int id) {
    service.DeleteSaksi(id);
    setState(() {
      widget.list.removeWhere((saksi) => saksi.id == id);
      searchResults.removeWhere((saksi) => saksi.id == id);
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

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  void _editSaksi(int id) async {
    SaksiModel? saksi = await service.GetSaksiDetail(id);
    TextEditingController nameController =
        TextEditingController(text: saksi!.user!.name);
    TextEditingController emailController =
        TextEditingController(text: saksi.user!.email);
    TextEditingController telephoneController =
        TextEditingController(text: saksi.user!.telephone);
    String _provSelected = saksi.provinsi!.id.toString();
    String _kabSelected = saksi.kabupaten!.id.toString();
    String _kecSelected = saksi.kecamatan!.id.toString();
    String _kelSelected = saksi.kelurahan!.id.toString();
    TextEditingController tpsController =
        TextEditingController(text: saksi.tps!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Edit Saksi'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: telephoneController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Telephone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60,
                    width: 350,
                    child: FutureBuilder(
                      future: service.showProvinsi(),
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
                                _provSelected = value!;
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
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60,
                    width: 350,
                    child: FutureBuilder(
                      future: service.showKab(_provSelected),
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
                                        kabupaten.nama.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: _kabSelected,
                            onChanged: (value) {
                              setState(() {
                                kabselect = value;
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
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60,
                    width: 350,
                    child: FutureBuilder(
                      future: service.showkecamatan(_kabSelected),
                      builder: (context, snapshot) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'kecamatan',
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
                                        kecamatan.nama.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: _kecSelected,
                            onChanged: (value) {
                              setState(() {
                                _kecSelected = value!;
                                print(_kecSelected);
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
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 60,
                    width: 350,
                    child: FutureBuilder(
                      future: service.showkelurahan(_kecSelected),
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
                                        kelurahan.nama.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: _kelSelected,
                            onChanged: (value) {
                              setState(() {
                                _kelSelected = value!;
                                print(_kelSelected);
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
                  SizedBox(height: 15),
                  TextField(
                    controller: tpsController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'TPS',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await service.EditSaksi(
                        saksi.id!,
                        nameController.text,
                        emailController.text,
                        telephoneController.text,
                        _provSelected,
                        _kabSelected,
                        _kecSelected,
                        _kelSelected,
                        tpsController.text,
                      );
                      widget.refresh();
                        await service.GetAllDataSaksi();
                        setState(() {
                          searchResults = widget.list;
                        });
                      Navigator.of(context)
                          .pop(); // Tutup dialog setelah simpan
                      ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Data berhasil disimpan'),
                            ),
                          );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("gagal :"+e.toString())));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(120, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'SIMPAN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  Widget textfield({
    required TextEditingController controller,
    required bool obscure,
    required String label,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void searchList(String query) {
    List<dynamic> results = [];
    results = widget.list
        .where((item) =>
            item.user!.name.toLowerCase().contains(query.toLowerCase()))
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
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(searchResults[index].user!.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () {
                                    _showSaksiDetailDialog(
                                        searchResults[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editSaksi(searchResults[index].id);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteSaksi(searchResults[index].id!);
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
