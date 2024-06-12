import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/Register/metod.dart';
import 'package:mapvotersapk/page/Saksi/DetailSaksi.dart';
import 'package:mapvotersapk/page/Saksi/RegisterSaksi.dart';

methodRegister getdata = methodRegister();

class Saksi extends StatefulWidget {
  final String judul;
  final List<SaksiModel> list;

  const Saksi({
    super.key,
    required this.labeltext,
    required this.judul,
    required this.list,
    required this.title,
  });

  final String labeltext;
  final String title;

  @override
  _SaksiState createState() => _SaksiState();
}

class _SaksiState extends State<Saksi> {
  late List<SaksiModel> filteredList;

  @override
  void initState() {
    super.initState();
    filteredList = widget.list;
  }

  void filterSearchResults(String query) {
    List<SaksiModel> dummySearchList = [];
    dummySearchList.addAll(widget.list);
    if (query.isNotEmpty) {
      List<SaksiModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.user?.name != null && item.user!.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredList.clear();
        filteredList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredList.clear();
        filteredList.addAll(widget.list);
      });
    }
  }

  void addSaksi(SaksiModel newSaksi) {
    setState(() {
      filteredList.add(newSaksi);
    });
  }

  void updateSaksi(SaksiModel updatedSaksi) {
    setState(() {
      int index = filteredList.indexWhere((saksi) => saksi.user?.email == updatedSaksi.user?.email);
      if (index != -1) {
        filteredList[index] = updatedSaksi;
      }
    });
  }

  void deleteSaksi(SaksiModel saksiToDelete) {
    setState(() {
      filteredList.removeWhere((saksi) => saksi.user?.email == saksiToDelete.user?.email);
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
                onChanged: (value) {
                  filterSearchResults(value); //textfield search
                },
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
                  future: getdata.showsaksi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (widget.list.isEmpty) {
                        return const Center(
                          child: Text("data tidak ditemukan"),
                        );
                      }
                    }
                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        var saksi = filteredList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(saksi.user?.name ?? 'No Name'),
                            subtitle: Text(saksi.user?.email ?? 'No Email'),
                            trailing: IconButton(
                              icon: const Icon(Icons.info),
                              onPressed: () {
                                Navigator.push(
                                  //nampilin detail data
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailSaksi(
                                      saksi: saksi,
                                      onSave: (updatedSaksi) {
                                        updateSaksi(updatedSaksi);
                                        Navigator.pop(context);
                                      },
                                      onDelete: (saksiToDelete) {
                                        deleteSaksi(saksiToDelete);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
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
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterSaksi(
                        onSave: (newSaksi) {
                          addSaksi(newSaksi);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                ),
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
