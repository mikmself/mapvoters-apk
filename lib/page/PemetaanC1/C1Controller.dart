import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/PemetaanC1/PemetaanSuaraservice.dart';
import 'package:mapvotersapk/page/Saksi/RegisterSaksi.dart';

Service service = Service();

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
  String currentlevel = 'provinsi';

  var role = 'paslon';

  @override
  void initState() {
    super.initState();
  }

  void fetchProvinsi() async {
    var result = await service.showProvinsi();
    setState(() {
      // showKabupaten = false;
      currentlevel = 'provinsi';
    });
  }

  void fetchKabupaten(String provinsiId) async {
    var result = await service.showKab(
        provinsiId); // Assuming you have a similar method to fetch kabupaten
    setState(() {
      // showKabupaten = true;
      currentlevel = 'kabupaten';
    });
  }

  void fetchKecamatan(String kabupatenId) async {
    var result = await service
        .showKec(kabupatenId); // Assuming you have a method to fetch kelurahan
    setState(() {
      // ShowKecamatan = true;
      currentlevel = 'kecamatan';
    });
  }

  void fetchKelurahan(String kecamatanId) async {
    var result = await service
        .showKel(kecamatanId); // Assuming you have a method to fetch kelurahan
    setState(() {
      // ShowKelurahan = true;
      currentlevel = 'kelurahan';
    });
  }

  void fetchTPS(id, String kelurahanId) async {
    var result = await service.showTPS(
        id, kelurahanId); // Assuming you have a method to fetch kelurahan
    setState(() {
      // ShowTPS = true;
      currentlevel = 'TPS';
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
                          if (currentlevel == 'TPS') {
                            setState(() {
                              currentlevel = 'kelurahan';
                            });
                          } else if (currentlevel == 'kelurahan') {
                            setState(() {
                              currentlevel = 'kecamatan';
                            });
                          } else if (currentlevel == 'kecamatan') {
                            setState(() {
                              currentlevel = 'kabupaten';
                            });
                          } else if (currentlevel == 'kabupaten') {
                            setState(() {
                              currentlevel = 'provinsi';
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
                    future: service.showProvinsi(),
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
                        itemCount: currentlevel == 'TPS'
                            ? TPSlist.length
                            : currentlevel == 'kelurahan'
                                ? kelurahanList.length
                                : currentlevel == 'kecamatan'
                                    ? kecamatanList.length
                                    : currentlevel == 'kabupaten'
                                        ? kabupatenList.length
                                        : provinsiList.length,
                        itemBuilder: (context, index) {
                          if (currentlevel == 'TPS') {
                            return GestureDetector(
                              onTap: () async {
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
                                              TPSlist[index].fotoKertasSuara!),
                                          SizedBox(height: 8),
                                          Text('TPS : ${TPSlist[index].tps}'),
                                          SizedBox(height: 8),
                                          Text(
                                              'Jumlah Suara : ${TPSlist[index].jumlahSuara}')
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(TPSlist[index].tps!),
                                ),
                              ),
                            );
                          } else if (currentlevel == 'kelurahan') {
                            return GestureDetector(
                              onTap: () {
                                fetchTPS(1, kelurahanList[index].id!);
                              },
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(kelurahanList[index].nama!),
                                ),
                              ),
                            );
                          } else if (currentlevel == 'kecamatan') {
                            return GestureDetector(
                              onTap: () {
                                fetchKelurahan(kecamatanList[index].id!);
                              },
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(kecamatanList[index].nama!),
                                ),
                              ),
                            );
                          } else if (currentlevel == 'kabupaten') {
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
            Visibility(
              visible: role != role,
              child: Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterSaksi(),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
