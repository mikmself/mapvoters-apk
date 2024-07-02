class KelurahanModel {
  String? id;
  String? nama;
  String? kecamatanId;

  KelurahanModel({this.id, this.nama, this.kecamatanId});

  KelurahanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kecamatanId = json['kecamatan_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['kecamatan_id'] = this.kecamatanId;
    return data;
  }
}