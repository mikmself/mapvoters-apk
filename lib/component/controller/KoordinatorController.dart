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
    required this.onItemSelected, 
    required this.refresh,
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
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      BASE_URL.replaceFirst('/api', '/') + (koordinator.foto ?? ''),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Detail Koordinator',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildDetailRow('Nama', koordinator.user!.name ?? ''),
                        _buildDetailRow('NIK', koordinator.nik ?? ''),
                        _buildDetailRow('Email', koordinator.user!.email ?? ''),
                        _buildDetailRow('Telephone', koordinator.user!.telephone ?? ''),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Tutup',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detail Koordinator'),
            content: Text('Koordinator dengan ID $id tidak ditemukan.'),
            actions: <Widget>[
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

  void _editKoordinator(KoordinatorModel koordinator) {
    TextEditingController _namacontroller = TextEditingController(text: koordinator.user!.name);
    TextEditingController _NIKcontroller = TextEditingController(text: koordinator.nik);
    TextEditingController _emailcontroller = TextEditingController(text: koordinator.user!.email);
    TextEditingController _noHPcontroller = TextEditingController(text: koordinator.user!.telephone);
    TextEditingController _passwordcontroller = TextEditingController(text: '');

    File? _imageFile;
    String? _imageUrl = koordinator.foto != null ? BASE_URL.replaceFirst('/api', '/') + koordinator.foto! : null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Koordinator'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        File? pickedFile = await _pickAnyFile(context);
                        if (pickedFile != null) {
                          setState(() {
                            _imageFile = pickedFile;
                            _imageUrl = null; // Clear the URL to show the picked file
                          });
                        }
                      },
                      onLongPress: _imageFile != null
                          ? () {
                        _showImageDialog(context, _imageFile!);
                      }
                          : null,
                      child: SizedBox(
                        width: 270,
                        height: 250,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _imageFile != null
                                  ? FileImage(_imageFile!) as ImageProvider
                                  : NetworkImage(_imageUrl!),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(),
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _namacontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _NIKcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'NIK',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _emailcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _noHPcontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Telephone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        service.EditKoordinator(
                          koordinator.id!,
                          _namacontroller.text,
                          _NIKcontroller.text,
                          _emailcontroller.text,
                          _noHPcontroller.text,
                          _passwordcontroller.text,
                          _imageFile,
                        );
                        widget.refresh();
                        service.GetAllDataKoordinator();
                        Navigator.of(context).pop(); // Tutup dialog setelah simpan
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
              ),
            );
          },
        );
      },
    );
  }

  Future<File?> _pickAnyFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      return File(result.files.first.path!);
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