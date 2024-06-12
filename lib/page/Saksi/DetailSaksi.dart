import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/model/SaksiModel.dart';
import 'package:mapvotersapk/page/Saksi/RegisterSaksi.dart';

class DetailSaksi extends StatelessWidget {
  final SaksiModel saksi;
  final Function(SaksiModel) onSave; // Callback untuk menyimpan data yang telah diedit
  final Function(SaksiModel) onDelete; // Callback untuk menghapus data yang telah dihapus

  DetailSaksi({required this.saksi, required this.onSave, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(saksi.user!.name ?? 'Detail Saksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: ${saksi.user?.name}"),
            Text("Email: ${saksi.user?.email}"),
            Text("No Telphone: ${saksi.user?.telephone}"),
            Text("Provinsi: ${saksi.provinsi?.nama}"),
            Text("Kabupaten: ${saksi.kabupaten?.nama}"),
            Text("Kecamatan: ${saksi.kecamatan?.nama}"),
            Text("Kelurahan: ${saksi.kelurahan?.nama}"),
            Text("TPS: ${saksi.tps}"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Registersaksi(onBack: () {
                          
                        },
                          // saksi: saksi,
                          // onSave: (updatedSaksi) {
                          //   onSave(updatedSaksi);
                          //   Navigator.pop(context);
                          // },
                        ),
                      ),
                    );
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onDelete(saksi);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.red,
                  ),
                  child: Text('Hapus'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
