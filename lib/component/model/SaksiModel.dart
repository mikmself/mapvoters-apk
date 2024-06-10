import 'package:mapvotersapk/component/model/KabupatenModel.dart';
import 'package:mapvotersapk/component/model/KecamatanModel.dart';
import 'package:mapvotersapk/component/model/KelurahanModel.dart';
import 'package:mapvotersapk/component/model/KoordinatorModel.dart';
import 'package:mapvotersapk/component/model/ProvinsiModel.dart';
import 'package:mapvotersapk/component/model/UserMode.dart';

class SaksiModel {
  int? id;
  String? tps;
  int? jumlahSuara;
  String? fotoKertasSuara;
  int? userId;
  ProvinsiModel? provinsi;
  KabupatenModel? kabupaten;
  KecamatanModel? kecamatan;
  KelurahanModel? kelurahan;
  UserModel? user;
  KoordinatorModel? koordinator;

  SaksiModel(
      {this.id,
        this.tps,
        this.jumlahSuara,
        this.fotoKertasSuara,
        this.userId,
        this.provinsi,
        this.kabupaten,
        this.kecamatan,
        this.kelurahan,
        this.user,
        this.koordinator});

  SaksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tps = json['tps'];
    jumlahSuara = json['jumlah_suara'];
    fotoKertasSuara = json['foto_kertas_suara'];
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
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    koordinator = json['koordinator'] != null
        ? new KoordinatorModel.fromJson(json['koordinator'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tps'] = this.tps;
    data['jumlah_suara'] = this.jumlahSuara;
    if (this.provinsi != null) {
      data['provinsi'] = this.provinsi!.toJson();
    }
    if (this.kabupaten != null) {
      data['kabupaten'] = this.kabupaten!.toJson();
    }
    if (this.kecamatan != null) {
      data['kecamatan'] = this.kecamatan!.toJson();
    }
    if (this.kelurahan != null) {
      data['kelurahan'] = this.kelurahan!.toJson();
    }
    if (this.koordinator != null) {
      data['koordinator'] = this.koordinator!.toJson();
    }
    return data;
  }
}