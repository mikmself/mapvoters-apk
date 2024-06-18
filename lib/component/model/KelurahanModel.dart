import 'package:mapvotersapk/component/model/KecamatanModel.dart';

class KelurahanModel {
  String? id;
  String? nama;
  KecamatanModel? kecamatan;

  KelurahanModel({this.id, this.nama, this.kecamatan});

  KelurahanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kecamatan = json['kecamatan_id'] != null
        ? new KecamatanModel.fromJson(json['kecamatan_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    if (this.kecamatan != null) {
      data['kecamatan_id'] = this.kecamatan!.toJson();
    }
    return data;
  }
}
