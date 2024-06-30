// lib/page/PemetaanSuara/model/modelKecamatan.dart
class modelKecamatan {
  String? id;
  String? nama;
  String? kabupatenId;
  int? pemilihPotensialCount;

  modelKecamatan({this.id, this.nama, this.kabupatenId, this.pemilihPotensialCount});

  modelKecamatan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kabupatenId = json['kabupaten_id'];
    pemilihPotensialCount = json['pemilih_potensial_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kabupaten_id'] = kabupatenId;
    data['pemilih_potensial_count'] = pemilihPotensialCount;
    return data;
  }
}
