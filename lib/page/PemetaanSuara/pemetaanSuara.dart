import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/page/PemetaanSuara/model/ListModel.dart';
import 'package:mapvotersapk/page/PemetaanSuara/pemetaan_suara_service.dart';
import 'package:mapvotersapk/page/dashboard.dart';

class Pemetaansuara extends StatefulWidget {
  const Pemetaansuara({super.key, required String title});

  @override
  State<Pemetaansuara> createState() => _PemetaansuaraState();
}

class _PemetaansuaraState extends State<Pemetaansuara> {
  String judul = "Provinsi";
  TextEditingController cariWilayah = TextEditingController();
  PemetaanSuaraService service = PemetaanSuaraService();
  List<dynamic> ListDataPage = [];
  String Pageaktifasaatini = "Provinsi";

  @override
  void initState() {
    super.initState();
    pageProvinsi(loginData['userID']);
  }

  //Method inisialisasi halamaan di gunkana untuk menginisialisasi halamaan
  void pageProvinsi(id) async {
    await service.showProvinsi(id);
    setState(() {
      Pageaktifasaatini = "Provinsi";
      ListDataPage = provinsiList;
      judul = "Provinsi";
    });
  }

  void pageKabupaten(String provinsiID, id) async {
    await service.showKabupaten(provinsiID, id);
    setState(() {
      Pageaktifasaatini = "Kabupaten";
      ListDataPage = kabupatenList;
      judul = "Kabupaten";
    });
  }

  void pageKecamatan(String kabupatenID, id) async {
    await service.showKecamatan(kabupatenID, id);
    setState(() {
      Pageaktifasaatini = "Kecamatan";
      ListDataPage = kecamatanList;
      judul = "Kecamatan";
    });
  }

  void pageKelurahan(String kecamatanID, id) async {
    await service.showKelurahan(kecamatanID, id);
    setState(() {
      Pageaktifasaatini = "Kelurahan";
      ListDataPage = kelurahanList;
      judul = "Kelurahan";
    });
  }

  void navigateBack() {
    if (Pageaktifasaatini == 'Kelurahan') {
      setState(() {
        Pageaktifasaatini = 'Kecamatan';
        ListDataPage = kecamatanList;
        judul = 'Kecamatan';
      });
    } else if (Pageaktifasaatini == 'Kecamatan') {
      setState(() {
        Pageaktifasaatini = 'Kabupaten';
        ListDataPage = kabupatenList;
        judul = 'Kabupaten';
      });
    } else if (Pageaktifasaatini == 'Kabupaten') {
      setState(() {
        Pageaktifasaatini = 'Provinsi';
        ListDataPage = provinsiList;
        judul = 'Provinsi';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Methode back yang di gunakan user dengan tombol back
    return WillPopScope(
      onWillPop: () async {
        if (Pageaktifasaatini != 'Provinsi') {
          navigateBack();
          return false;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(title: 'Dashboard'),
            ),
          );
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pemetaan Suara $judul",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            if (Pageaktifasaatini != 'Provinsi')
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: navigateBack,
              ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextField(
                controller: cariWilayah,
                decoration: InputDecoration(
                  labelText: 'Cari $judul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  searchList(value);
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: service.showProvinsi(loginData['userID']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: ListDataPage.length,
                      itemBuilder: (context, index) {
                        var item = ListDataPage[index];
                        print('Building container for: ${item.nama}');
                        return GestureDetector(
                          onTap: () {
                            if (Pageaktifasaatini == 'Provinsi') {
                              pageKabupaten(item.id, loginData['userID']);
                            } else if (Pageaktifasaatini == 'Kabupaten') {
                              pageKecamatan(item.id, loginData['userID']);
                            } else if (Pageaktifasaatini == 'Kecamatan') {
                              pageKelurahan(item.id, loginData['userID']);
                            }
                          },
                          child: _buildInfoContainer(
                              item.nama!, item.pemilihPotensialCount!),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchList(String query) {
    List<dynamic> results = [];
    if (Pageaktifasaatini == 'Provinsi') {
      results = provinsiList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (Pageaktifasaatini == 'Kabupaten') {
      results = kabupatenList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (Pageaktifasaatini == 'Kecamatan') {
      results = kecamatanList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (Pageaktifasaatini == 'Kelurahan') {
      results = kelurahanList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      ListDataPage = results;
    });
  }

  Widget _buildInfoContainer(String Wilayah, int Pemili_Potensial) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 255, 255),
            border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    Wilayah,
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 113, 255, 220),
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      Pemili_Potensial.toString(),
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemetaan Suara App',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Pemetaansuara(title: 'Pemetaan Suara'),
    );
  }
}
