class KabupatenModel {
  String? id;
  String? nama;
  String? provinsiId;

  KabupatenModel({this.id, this.nama, this.provinsiId});

  KabupatenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    provinsiId = json['provinsi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['provinsi_id'] = this.provinsiId;
    return data;
  }
}