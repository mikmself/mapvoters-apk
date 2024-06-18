class TPSModel {
  String? tps;
  int? jumlahSuara;
  String? fotoKertasSuara;

  TPSModel({this.tps, this.jumlahSuara, this.fotoKertasSuara});

  TPSModel.fromJson(Map<String, dynamic> json) {
    tps = json['tps'];
    jumlahSuara = json['jumlah_suara'];
    fotoKertasSuara = json['foto_kertas_suara'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tps'] = this.tps;
    data['jumlah_suara'] = this.jumlahSuara;
    data['foto_kertas_suara'] = this.fotoKertasSuara;
    return data;
  }
}
