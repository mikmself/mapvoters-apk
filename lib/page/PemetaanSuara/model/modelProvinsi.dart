class modelProvinsi {
  String? id;
  String? nama;
  int? pemilihPotensialCount;

  modelProvinsi({this.id, this.nama, this.pemilihPotensialCount});

  modelProvinsi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    pemilihPotensialCount = json['pemilih_potensial_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['pemilih_potensial_count'] = pemilihPotensialCount;
    return data;
  }
}
