class koorModel {
  int? id;
  String? nik;
  String? foto;
  int? paslonId;
  int? userId;
  userModel? user;

  koorModel({
    this.id,
    this.nik,
    this.foto,
    this.paslonId,
    this.userId,
    this.user,
  });

  koorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    foto = json['foto'];
    paslonId = json['paslon_id'];
    userId = json['user_id'];
    user = json['user'] != null ? new userModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['foto'] = this.foto;
    data['paslon_id'] = this.paslonId;
    data['user_id'] = this.userId;

    return data;
  }
}

class saksiModel {
  int? id;
  String? tps;
  int? jumlahSuara;
  String? fotoKertasSuara;
  int? userId;
  provinsiModel? provinsi;
  kabModel? kabupaten;
  kecModel? kecamatan;
  kelModel? kelurahan;
  userModel? user;
  koorModel? koordinator;

  saksiModel(
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

  saksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tps = json['tps'];
    jumlahSuara = json['jumlah_suara'];
    fotoKertasSuara = json['foto_kertas_suara'];
    provinsi = json['provinsi'] != null
        ? new provinsiModel.fromJson(json['provinsi'])
        : null;
    kabupaten = json['kabupaten'] != null
        ? new kabModel.fromJson(json['kabupaten'])
        : null;
    kecamatan = json['kecamatan'] != null
        ? new kecModel.fromJson(json['kecamatan'])
        : null;
    kelurahan = json['kelurahan'];
    koordinator = json['koordinator'] != null
        ? new koorModel.fromJson(json['koordinator'])
        : null;
    user = json['user'] != null ? new userModel.fromJson(json['user']) : null;
    koordinator = json['koordinator'] != null
        ? new koorModel.fromJson(json['koordinator'])
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

    if (this.koordinator != null) {
      data['koordinator'] = this.koordinator!.toJson();
    }
    return data;
  }
}

class pemilihModel {
  int? id;
  String? nama;
  String? nik;
  String? fotoKtp;
  String? telephone;
  String? tps;
  provinsiModel? provinsi;
  kabModel? kabupaten;
  kecModel? kecamatan;
  // Null? kelurahan;
  koorModel? koordinator;
  pemilihModel(
      this.id,
      this.nama,
      this.nik,
      this.fotoKtp,
      this.telephone,
      this.tps,
      this.provinsi,
      this.kabupaten,
      this.kecamatan,
      // this.kelurahan,
      this.koordinator);

  pemilihModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nik = json['nik'];
    fotoKtp = json['foto_ktp'];
    telephone = json['telephone'];
    tps = json['tps'];
    provinsi = json['provinsi'] != null
        ? new provinsiModel.fromJson(json['provinsi'])
        : null;
    kabupaten = json['kabupaten'] != null
        ? new kabModel.fromJson(json['kabupaten'])
        : null;
    kecamatan = json['kecamatan'] != null
        ? new kecModel.fromJson(json['kecamatan'])
        : null;
    // kelurahan = json['kelurahan'];
    koordinator = json['koordinator'] != null
        ? new koorModel.fromJson(json['koordinator'])
        : null;
  }
}

class provinsiModel {
  String? id;
  String? nama;

  provinsiModel({this.id, this.nama});

  provinsiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    return data;
  }
}

class kabModel {
  String? id;
  String? nama;
  String? provinsiId;

  kabModel({this.id, this.nama, this.provinsiId});

  kabModel.fromJson(Map<String, dynamic> json) {
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

class kecModel {
  String? id;
  String? nama;
  String? kabupatenId;

  kecModel({this.id, this.nama, this.kabupatenId});

  kecModel.fromJson(Map<String, dynamic> json) {
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

class kelModel {
  String? Kelurahan;
  int? suara;
  int? kode;
  kelModel(
    this.Kelurahan,
    this.suara,
    this.kode,
  );
}

class userModel {
  int? id;
  String? name;
  String? email;
  String? telephone;
  String? role;

  userModel({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.role,
  });

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['role'] = this.role;

    return data;
  }
}

List<pemilihModel> pemilihlist = [];
List<saksiModel> saksiList = [];
List<provinsiModel> provinsi = [];
List<koorModel> koorlist = [];
List<dynamic> partailist = [];

class partaiModel {
  int? id;
  String? nama;

  partaiModel({
    this.id,
    this.nama,
  });

  partaiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;

    return data;
  }
}
