import 'package:mapvotersapk/component/model/ProvinsiModel.dart';

class KabupatenModel {
  String? id;
  String? nama;
  ProvinsiModel? provinsi;

  KabupatenModel({this.id, this.nama, this.provinsi});

  KabupatenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    provinsi = json['provinsi_id'] != null
        ? new ProvinsiModel.fromJson(json['provinsi_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    if (this.provinsi != null) {
      data['provinsi_id'] = this.provinsi!.toJson();
    }
    return data;
  }
}