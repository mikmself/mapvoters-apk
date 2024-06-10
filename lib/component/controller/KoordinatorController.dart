import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapvotersapk/component/service/KoordinatorService.dart';
import 'package:mapvotersapk/component/sidebar.dart';

KoordinatorService service = KoordinatorService();

class GetAllDataKoordinator extends StatelessWidget {
  final String judul;
  final List list;
  final ValueChanged<int> onItemSelected;

  const GetAllDataKoordinator({
    super.key,
    required this.labeltext,
    required this.judul,
    required this.list,
    required this.onItemSelected,
  });

  final String labeltext;

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
                  future: service.ShowDataKoordinator(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (list.length == 0) {
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
                            title: Text(list[index].user!.name), //perbedaan
                            trailing: IconButton(
                                icon: const Icon(Icons.info),
                                onPressed: () {
                                  // onItemSelected(1);
                                }),
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
                onItemSelected(1);
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
