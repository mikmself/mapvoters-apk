import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';

class PemilihModel {
  int? id;
  String? nama;
  String? nik;
  String? fotoKtp;
  String? telephone;
  String? tps;
  ProvinsiModel? provinsi;
  KabupatenModel? kabupaten;
  KecamatanModel? kecamatan;
  KelurahanModel? kelurahan;
  KoordinatorModel? koordinator;
  PemilihModel(
      this.id,
      this.nama,
      this.nik,
      this.fotoKtp,
      this.telephone,
      this.tps,
      this.provinsi,
      this.kabupaten,
      this.kecamatan,
      this.kelurahan,
      this.koordinator);

  PemilihModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nik = json['nik'];
    fotoKtp = json['foto_ktp'];
    telephone = json['telephone'];
    tps = json['tps'];
    provinsi = json['provinsi'] != null
        ? new ProvinsiModel.fromJson(json['provinsi'])
        : null;
    kabupaten = json['kabupaten'] != null
        ? new KabupatenModel.fromJson(json['kabupaten'])
        : null;
    kecamatan = json['kecamatan'] != null
        ? new KecamatanModel.fromJson(json['kecamatan'])
        : null;
    kelurahan = json['kelurahan'] != null
        ? new KelurahanModel.fromJson(json['kelurahan'])
        : null;
    koordinator = json['koordinator'] != null
        ? new KoordinatorModel.fromJson(json['koordinator'])
        : null;
  }
}