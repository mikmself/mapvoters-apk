import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/TPSModel.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/PemetaanC1/PemetaanSuaraservice.dart';
import 'package:mapvotersapk/page/Saksi/RegisterSaksi.dart';

Service service = Service();

class PemetaanSuaraC1 extends StatefulWidget {
  final String labeltext;
  final String title;

  PemetaanSuaraC1({
    Key? key,
    required this.labeltext,
    required this.title,
  }) : super(key: key);

  @override
  _PemetaanSuaraC1State createState() => _PemetaanSuaraC1State();
}

class _PemetaanSuaraC1State extends State<PemetaanSuaraC1> {
  String judul = 'Provinsi';
  String currentlevel = 'provinsi';
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchProvinsi(loginData['userID']);
  }

  void fetchProvinsi(id) async {
    await service.showProvinsi(id);
    setState(() {
      currentlevel = 'provinsi';
      searchResults = provinsiList;
      judul = 'Provinsi';
    });
  }

  void fetchKabupaten(String provinsiId, id) async {
    await service.showKab(provinsiId, id);
    setState(() {
      currentlevel = 'kabupaten';
      searchResults = kabupatenList;
      judul = 'Kabupaten';
    });
  }

  void fetchKecamatan(String kabupatenId, id) async {
    await service.showKec(kabupatenId, id);
    setState(() {
      currentlevel = 'kecamatan';
      searchResults = kecamatanList;
      judul = 'Kecamatan';
    });
  }

  void fetchKelurahan(String kecamatanId, id) async {
    await service.showKel(kecamatanId, id);
    setState(() {
      currentlevel = 'kelurahan';
      searchResults = kelurahanList;
      judul = 'Kelurahan';
    });
  }

  void fetchTPS(id, String kelurahanId) async {
    await service.showTPS(kelurahanId, id);
    setState(() {
      currentlevel = 'TPS';
      searchResults = TPSlist;
      judul = 'TPS';
    });
  }

  void searchList(String query) {
    List<dynamic> results = [];
    if (currentlevel == 'provinsi') {
      results = provinsiList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (currentlevel == 'kabupaten') {
      results = kabupatenList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (currentlevel == 'kecamatan') {
      results = kecamatanList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (currentlevel == 'kelurahan') {
      results = kelurahanList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (currentlevel == 'TPS') {
      results = TPSlist.where(
              (item) => item.tps!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      searchResults = results;
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
                      Text(judul,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          )),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (currentlevel == 'TPS') {
                            setState(() {
                              currentlevel = 'kelurahan';
                              searchResults = kelurahanList;
                              judul = 'Kelurahan';
                            });
                          } else if (currentlevel == 'kelurahan') {
                            setState(() {
                              currentlevel = 'kecamatan';
                              searchResults = kecamatanList;
                              judul = 'Kecamatan';
                            });
                          } else if (currentlevel == 'kecamatan') {
                            setState(() {
                              currentlevel = 'kabupaten';
                              searchResults = kabupatenList;
                              judul = 'Kabupaten';
                            });
                          } else if (currentlevel == 'kabupaten') {
                            setState(() {
                              currentlevel = 'provinsi';
                              searchResults = provinsiList;
                              judul = 'Provinsi';
                            });
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SidebarApp(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: searchController,
                  onChanged: searchList,
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
                    future: service.showProvinsi(loginData['userID']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (searchResults.isEmpty) {
                          return const Center(
                            child: Text("Data tidak ditemukan"),
                          );
                        }
                      }
                      return ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          var item = searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              searchController.clear();
                              if (currentlevel == 'provinsi') {
                                fetchKabupaten(item.id, loginData['userID']);
                              } else if (currentlevel == 'kabupaten') {
                                fetchKecamatan(item.id, loginData['userID']);
                              } else if (currentlevel == 'kecamatan') {
                                fetchKelurahan(item.id, loginData['userID']);
                              } else if (currentlevel == 'kelurahan') {
                                fetchTPS(loginData['userID'], item.id!);
                              } else if (currentlevel == 'TPS') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Detail Suara'),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.network(BASE_URL.replaceFirst(
                                                  '/api', '/c1/') +
                                              item.fotoKertasSuara!),
                                          SizedBox(height: 8),
                                          Text('TPS : ${item.tps}'),
                                          SizedBox(height: 8),
                                          Text(
                                              'Jumlah Suara : ${item.jumlahSuara}')
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text(
                                    item is TPSModel ? item.tps! : item.nama!),
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
            // Visibility(
            //   visible: widget.role != ,
            //   child: Positioned(
            //     bottom: 16,
            //     right: 16,
            //     child: FloatingActionButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => RegisterSaksi(),
            //           ),
            //         );
            //       },
            //       child: Icon(Icons.add),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
