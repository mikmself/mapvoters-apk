class PartaiModel {
  int? id;
  String? nama;
  String? nomorUrut;
  String? logo;

  PartaiModel({
    this.id,
    this.nama,
    this.nomorUrut,
    this.logo,
  });

  PartaiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nomorUrut = json['nomor_urut'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['nomor_urut'] = this.nomorUrut;
    data['logo'] = this.logo;
    return data;
  }
}