import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';
import 'package:mapvotersapk/component/service/KoordinatorService.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/Koordinator/Koordinator.dart';

KoordinatorService service = KoordinatorService();

class GetAllDataKoordinator extends StatefulWidget {
  final String judul;
  final List list;
  final ValueChanged<int> onItemSelected;
  final VoidCallback refresh;

  const GetAllDataKoordinator({
    super.key,
    required this.judul,
    required this.list,
    required this.onItemSelected, required this.refresh,
  });

  @override
  _GetAllDataKoordinatorState createState() => _GetAllDataKoordinatorState();
}

class _GetAllDataKoordinatorState extends State<GetAllDataKoordinator> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = widget.list;
  }

  void _deleteKoordinator(int id) {
    service.DeleteKoordinator(id);
    setState(() {
      widget.list.removeWhere((koordinator) => koordinator.id == id);
      searchResults.removeWhere((koordinator) => koordinator.id == id);
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
    TextEditingController _namacontroller = TextEditingController(text: koordinator.user!.name);
    TextEditingController _NIKcontroller = TextEditingController(text: koordinator.nik);
    TextEditingController _emailcontroller = TextEditingController(text: koordinator.user!.email);
    TextEditingController _noHPcontroller = TextEditingController(text: koordinator.user!.telephone);
    TextEditingController _passwordcontroller = TextEditingController(text: '');
    File? _imageFile = koordinator.foto != null ? File(BASE_URL.replaceFirst('/api', '/') + koordinator.foto!) : File('');
    String? _imageUrl = koordinator.foto != null ? BASE_URL.replaceFirst('/api', '/') + koordinator.foto! : null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Koordinator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: textfield(
                  controller: _namacontroller,
                  obscure: false,
                  label: 'Nama',
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                flex: 2,
                child: textfield(
                  controller: _NIKcontroller,
                  obscure: false,
                  label: 'NIK',
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                flex: 2,
                child: textfield(
                  controller: _emailcontroller,
                  obscure: false,
                  label: 'Email',
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                flex: 2,
                child: textfield(
                  controller: _noHPcontroller,
                  obscure: false,
                  label: 'Telephone',
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                flex: 2,
                child: textfield(
                  controller: _passwordcontroller,
                  obscure: true,
                  label: 'Password',
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                flex: 5,
                child: Container(
                  width: 350,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            _pickAnyFile(context).then((file) {
                              setState(() {
                                _imageFile = file;
                              });
                            });
                          },
                          onLongPress: () {
                            _showImageDialog(context, _imageFile!);
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _imageUrl != null
                                      ? NetworkImage(_imageUrl)
                                      : NetworkImage(BASE_URL.replaceFirst('/api', '/') + koordinator.foto!),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(),
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                service.EditKoordinator(
                                  koordinator.id!,
                                  _namacontroller.text,
                                  _NIKcontroller.text,
                                  _emailcontroller.text,
                                  _noHPcontroller.text,
                                  _passwordcontroller.text,
                                );
                                widget.refresh();
                                Navigator.of(context).pop(); // Tutup dialog setelah simpan
                              },
                              child: Text(
                                "SIMPAN",
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File?> _pickAnyFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.first.path!);
      return file;
    } else {
      return null;
    }
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
        .where((item) => item.user!.name.toLowerCase().contains(query.toLowerCase()))
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
                  future: service.GetAllDataKoordinator(),
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
                            title: Text(searchResults[index].user!.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info),
                                  onPressed: () {
                                    _showKoordinatorDetailDialog(searchResults[index].id!);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editKoordinator(searchResults[index]);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteKoordinator(searchResults[index].id!);
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
void _showImageDialog(BuildContext context, File imageFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}