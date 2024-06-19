import 'package:mapvotersapk/component/model/KabupatenModel.dart';

class KecamatanModel {
  String? id;
  String? nama;
  KabupatenModel? kabupaten;

  KecamatanModel({this.id, this.nama, this.kabupaten});

  KecamatanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kabupaten = json['kabupaten_id'] != null
        ? new KabupatenModel.fromJson(json['kabupaten_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    if (this.kabupaten != null) {
      data['kabupaten_id'] = this.kabupaten!.toJson();
    }
    return data;
  }
}