class modelKabupaten {
  String? id;
  String? nama;
  String? provinsiId;
  int? pemilihPotensialCount;

  modelKabupaten(
      {this.id, this.nama, this.provinsiId, this.pemilihPotensialCount});

  modelKabupaten.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    provinsiId = json['provinsi_id'];
    pemilihPotensialCount = json['pemilih_potensial_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['provinsi_id'] = provinsiId;
    data['pemilih_potensial_count'] = pemilihPotensialCount;
    return data;
  }
}