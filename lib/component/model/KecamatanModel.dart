
class KecamatanModel {
  String? id;
  String? nama;
  String? kabupatenId;

  KecamatanModel({this.id, this.nama, this.kabupatenId});

  KecamatanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kabupatenId = json['kabupaten_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['kabupaten_id'] = this.kabupatenId;
    return data;
  }
}