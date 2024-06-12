import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';
import 'package:mapvotersapk/component/service/KoordinatorService.dart';
import 'package:mapvotersapk/component/sidebar.dart';

KoordinatorService service = KoordinatorService();

class GetAllDataKoordinator extends StatefulWidget {
  final String judul;
  final List list;
  final ValueChanged<int> onItemSelected;

  const GetAllDataKoordinator({
    super.key,
    required this.judul,
    required this.list,
    required this.onItemSelected,
  });

  @override
  _GetAllDataKoordinatorState createState() => _GetAllDataKoordinatorState();
}

class _GetAllDataKoordinatorState extends State<GetAllDataKoordinator> {
  void _deleteKoordinator(int id) {
    service.DeleteKoordinator(id);
    setState(() {
      widget.list.removeWhere((koordinator) => koordinator.id == id);
    });
  }
  void _showKoordinatorDetailDialog(int id) async {
    KoordinatorModel? koordinator = await service.GetKoordinatorDetail(id);
    if (koordinator != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detail Koordinator'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(BASE_URL.replaceFirst('/api', '/') + koordinator.foto!),
                Text('Nama: ${koordinator.user!.name}'),
                SizedBox(height: 8),
                Text('NIK: ${koordinator.nik}'),
                SizedBox(height: 8),
                Text('Email: ${koordinator.user!.email}'),
                SizedBox(height: 8),
                Text('Telephone: ${koordinator.user!.telephone}'),
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
  void _editKoordinator(KoordinatorModel koordinator) {
    final nameController = TextEditingController(text: koordinator.user!.name);
    final NIKController = TextEditingController(text: koordinator.nik);
    final emailController = TextEditingController(text: koordinator.user!.email);
    final phoneController = TextEditingController(text: koordinator.user!.telephone);
    final passwordController = TextEditingController(text: '');
    File? imageFile;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Koordinator'),
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
                controller: NIKController,
                decoration: InputDecoration(
                  labelText: 'NIK',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
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
                service.EditKoordinator(
                  koordinator.id!,
                  nameController.text,
                  NIKController.text,
                  emailController.text,
                  phoneController.text,
                  passwordController.text,
                  imageFile ?? File(''),
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
                  future: service.GetAllDataKoordinator(),
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
                                    _showKoordinatorDetailDialog(widget.list[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editKoordinator(widget.list[index]);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteKoordinator(widget.list[index].id!);
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
