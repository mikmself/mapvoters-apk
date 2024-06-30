

class modelKelurahan {
  String? id;
  String? nama;
  String? kecamatanId;
  int? pemilihPotensialCount;

  modelKelurahan(
      {this.id, this.nama, this.kecamatanId, this.pemilihPotensialCount});

  modelKelurahan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kecamatanId = json['kecamatan_id'];
    pemilihPotensialCount = json['pemilih_potensial_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['kecamatan_id'] = kecamatanId;
    data['pemilih_potensial_count'] = pemilihPotensialCount;
    return data;
  }
}