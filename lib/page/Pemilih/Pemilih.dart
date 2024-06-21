import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/component/sidebar.dart';
import 'package:mapvotersapk/page/Pemilih/Create_Pemilih.dart';
import 'package:mapvotersapk/page/Register/metod.dart';

methodRegister getdata = methodRegister();

class Pemilih extends StatelessWidget {
  final String judul;
  final List list;

  const Pemilih({
    super.key,
    required this.labeltext,
    required this.judul,
    required this.list, required this.title,
  });

  final String labeltext;
  final String title;
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
                    Text(judul,
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
                  labelText: labeltext,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: FutureBuilder(
                future: getdata.showpemilih(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (pemilihlist.length == 0) {
                      return const Center(
                        child: Text("data tidak ditemukaxn"),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(list[index].nama!), //perbedaan
                          trailing: IconButton(
                              icon: const Icon(Icons.info),
                              onPressed: () {
                                // Seharusnya show pemilih
                              }),
                        ),
                      );
                    },
                  );
                },
              )),
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
                      builder: (context) => CreatePemilih(),
                    ))
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
