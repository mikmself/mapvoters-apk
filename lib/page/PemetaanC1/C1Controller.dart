import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/PemetaanC1/PemetaanSuaraservice.dart';

import 'package:mapvotersapk/page/Saksi/RegisterSaksi.dart';

Service service1 = Service();

void main(List<String> args) {
  runApp(MyAp());
}

class MyAp extends StatelessWidget {
  const MyAp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PemetaanSuaraC1(
        labeltext: 'Cari',
        judul: 'Provinsi',
        title: 'Pemetaan C1',
      ),
    );
  }
}

class PemetaanSuaraC1 extends StatefulWidget {
  final String judul;

  const PemetaanSuaraC1({
    super.key,
    required this.labeltext,
    required this.judul,
    required this.title,
  });

  final String labeltext;
  final String title;

  @override
  _PemetaanSuaraC1State createState() => _PemetaanSuaraC1State();
}

class _PemetaanSuaraC1State extends State<PemetaanSuaraC1> {
  bool showKabupaten = false;
  bool ShowKecamatan = false;

  @override
  void initState() {
    super.initState();
  }

  void fetchProvinsi() async {
    var result = await service1.showProvinsi();
    setState(() {
      showKabupaten = false;
      showKabupaten = false;
      ShowKecamatan = false;
    });
  }

  void fetchKabupaten(String provinsiId) async {
    var result = await service1.showKab(
        provinsiId); // Assuming you have a similar method to fetch kabupaten
    setState(() {
      showKabupaten = true;
      ShowKecamatan = false;
    });
  }

  void fetchKecamatan(String kabupatenId) async {
    var result = await service1
        .showKec(kabupatenId); // Assuming you have a method to fetch kelurahan
    setState(() {
      ShowKecamatan = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                          if (showKabupaten) {
                          } else {}
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
                    labelText: widget.labeltext,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder(
                    future: service1.showProvinsi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (provinsiList.isEmpty) {
                          return const Center(
                            child: Text("Data tidak ditemukan"),
                          );
                        }
                      }
                      return ListView.builder(
                        itemCount: ShowKecamatan
                            ? kecamatanList.length
                            : showKabupaten
                                ? kabupatenList.length
                                : provinsiList.length,
                        itemBuilder: (context, index) {
                          if (ShowKecamatan) {
                            return GestureDetector(
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(kecamatanList[index].nama!),
                                ),
                              ),
                            );
                          } else if (showKabupaten) {
                            return GestureDetector(
                              onTap: () {
                                fetchKecamatan(kabupatenList[index].id!);
                              },
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(kabupatenList[index].nama!),
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                fetchKabupaten(provinsiList[index].id!);
                              },
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(provinsiList[index].nama!),
                                ),
                              ),
                            );
                          }
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
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterSaksi(),
                      ))
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
