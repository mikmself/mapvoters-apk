class ProvinsiModel {
  String? provinsi;
  int? suara;
  int? kode;
  ProvinsiModel(this.provinsi, this.suara, this.kode);
}

class KabModel {
  String? kabupaten;
  int? suara;
  int? kode;
  String? provinsi;
  KabModel(this.kabupaten, this.suara, this.kode, this.provinsi);
}

class KecModel {
  String? kecamatan;
  int? suara;
  int? kode;
  String? kabupaten;
  KecModel(this.kecamatan, this.suara, this.kode, this.kabupaten);
}

class KelModel {
  String? kelurahan;
  int? suara;
  int? kode;
  String? kecamatan;
  KelModel(this.kelurahan, this.suara, this.kode, this.kecamatan);
}

List<KelModel> kelurahan = [
  // Kelurahan di Purwokerto Selatan
  KelModel("Karangklesem", 854, 1, "Purwokerto Selatan"),
  KelModel("Berkoh", 932, 2, "Purwokerto Selatan"),
  // Kelurahan di Purwokerto Timur
  KelModel("Jatisari", 721, 3, "Purwokerto Timur"),
  KelModel("Kedunglumbu", 659, 4, "Purwokerto Timur"),
  // Kelurahan di Wonosobo Barat
  KelModel("Sambiroto", 898, 5, "Wonosobo Barat"),
  // Kelurahan di Kejajar
  KelModel("Bojong", 475, 6, "Kejajar"),
  // Kelurahan di Kalimanah
  KelModel("Sokaraja", 540, 7, "Kalimanah"),
  // Kelurahan di Purbalingga Kulon
  KelModel("Gumilir", 389, 8, "Purbalingga Kulon"),
  // Kelurahan di Cilacap Selatan
  KelModel("Karangasem", 630, 9, "Cilacap Selatan"),
  // Kelurahan di Brebes
  KelModel("Paguyangan", 783, 10, "Brebes"),
  // Tambahan data kelurahan
  KelModel("Kebumen", 800, 11, "Kebumen"),
  KelModel("Pejagoan", 750, 12, "Kebumen"),
  KelModel("Kawunganten", 680, 13, "Kawunganten"),
  KelModel("Adipala", 770, 14, "Adipala"),
  KelModel("Sampang", 720, 15, "Cilacap Utara"),
  KelModel("Margadana", 850, 16, "Tegal"),
  KelModel("Jatibarang", 600, 17, "Indramayu"),
  KelModel("Sukra", 550, 18, "Indramayu"),
  KelModel("Pasar Minggu", 500, 19, "Jakarta Selatan"),
  KelModel("Cilandak", 650, 20, "Jakarta Selatan"),
  // Kelurahan di Jawa Timur
  KelModel("Kedungdoro", 920, 21, "Surabaya"),
  KelModel("Ketintang", 850, 22, "Surabaya"),
  KelModel("Kedungasem", 700, 23, "Malang"),
  KelModel("Klojen", 770, 24, "Malang"),
  // Kelurahan di Jawa Barat
  KelModel("Dago", 800, 25, "Bandung"),
  KelModel("Braga", 900, 26, "Bandung"),
  KelModel("Antapani", 600, 27, "Bandung"),
  KelModel("Arcamanik", 650, 28, "Bandung"),
  // Kelurahan di Banten
  KelModel("Serpong", 710, 29, "Tangerang Selatan"),
  KelModel("Ciputat", 780, 30, "Tangerang Selatan"),
  KelModel("Pamulang", 860, 31, "Tangerang Selatan"),
  KelModel("Ciledug", 700, 32, "Tangerang"),
  // Kelurahan di DIY
  KelModel("Mergangsan", 690, 33, "Yogyakarta"),
  KelModel("Kotagede", 720, 34, "Yogyakarta"),
  KelModel("Umbulharjo", 640, 35, "Yogyakarta"),
  KelModel("Gondokusuman", 810, 36, "Yogyakarta"),
];

int calculateSuaraKecamatan(String kecamatan) {
  return kelurahan
      .where((kel) => kel.kecamatan == kecamatan)
      .fold(0, (sum, kel) => sum + kel.suara!);
}

List<KecModel> kecamatan = [
  KecModel("Purwokerto Selatan", calculateSuaraKecamatan("Purwokerto Selatan"), 1, "Banyumas"),
  KecModel("Purwokerto Timur", calculateSuaraKecamatan("Purwokerto Timur"), 2, "Banyumas"),
  KecModel("Wonosobo Barat", calculateSuaraKecamatan("Wonosobo Barat"), 3, "Wonosobo"),
  KecModel("Kejajar", calculateSuaraKecamatan("Kejajar"), 4, "Wonosobo"),
  KecModel("Kalimanah", calculateSuaraKecamatan("Kalimanah"), 5, "Purbalingga"),
  KecModel("Purbalingga Kulon", calculateSuaraKecamatan("Purbalingga Kulon"), 6, "Purbalingga"),
  KecModel("Cilacap Selatan", calculateSuaraKecamatan("Cilacap Selatan"), 7, "Cilacap"),
  KecModel("Cilacap Utara", calculateSuaraKecamatan("Cilacap Utara"), 8, "Cilacap"),
  KecModel("Brebes", calculateSuaraKecamatan("Brebes"), 9, "Brebes"),
  KecModel("Kebumen", calculateSuaraKecamatan("Kebumen"), 10, "Kebumen"),
  KecModel("Pejagoan", calculateSuaraKecamatan("Pejagoan"), 11, "Kebumen"),
  KecModel("Kawunganten", calculateSuaraKecamatan("Kawunganten"), 12, "Cilacap"),
  KecModel("Adipala", calculateSuaraKecamatan("Adipala"), 13, "Cilacap"),
  KecModel("Sampang", calculateSuaraKecamatan("Sampang"), 14, "Cilacap"),
  KecModel("Margadana", calculateSuaraKecamatan("Margadana"), 15, "Tegal"),
  KecModel("Jatibarang", calculateSuaraKecamatan("Jatibarang"), 16, "Indramayu"),
  KecModel("Sukra", calculateSuaraKecamatan("Sukra"), 17, "Indramayu"),
  KecModel("Pasar Minggu", calculateSuaraKecamatan("Pasar Minggu"), 18, "Jakarta Selatan"),
  KecModel("Cilandak", calculateSuaraKecamatan("Cilandak"), 19, "Jakarta Selatan"),
  // Kecamatan di Jawa Timur
  KecModel("Surabaya", calculateSuaraKecamatan("Surabaya"), 20, "Surabaya"),
  KecModel("Malang", calculateSuaraKecamatan("Malang"), 21, "Malang"),
  // Kecamatan di Jawa Barat
  KecModel("Bandung", calculateSuaraKecamatan("Bandung"), 22, "Bandung"),
  // Kecamatan di Banten
  KecModel("Tangerang Selatan", calculateSuaraKecamatan("Tangerang Selatan"), 23, "Tangerang Selatan"),
  KecModel("Tangerang", calculateSuaraKecamatan("Tangerang"), 24, "Tangerang"),
  // Kecamatan di DIY
  KecModel("Yogyakarta", calculateSuaraKecamatan("Yogyakarta"), 25, "Yogyakarta"),
];

int calculateSuaraKabupaten(String kabupaten) {
  return kecamatan
      .where((kec) => kec.kabupaten == kabupaten)
      .fold(0, (sum, kec) => sum + kec.suara!);
}

List<KabModel> kabupaten = [
  KabModel("Banyumas", calculateSuaraKabupaten("Banyumas"), 1, "Jawa Tengah"),
  KabModel("Wonosobo", calculateSuaraKabupaten("Wonosobo"), 2, "Jawa Tengah"),
  KabModel("Purbalingga", calculateSuaraKabupaten("Purbalingga"), 3, "Jawa Tengah"),
  KabModel("Cilacap", calculateSuaraKabupaten("Cilacap"), 4, "Jawa Tengah"),
  KabModel("Brebes", calculateSuaraKabupaten("Brebes"), 5, "Jawa Tengah"),
  KabModel("Kebumen", calculateSuaraKabupaten("Kebumen"), 6, "Jawa Tengah"),
  KabModel("Tegal", calculateSuaraKabupaten("Tegal"), 7, "Jawa Tengah"),
  KabModel("Indramayu", calculateSuaraKabupaten("Indramayu"), 8, "Jawa Barat"),
  KabModel("Jakarta Selatan", calculateSuaraKabupaten("Jakarta Selatan"), 9, "DKI Jakarta"),
  // Kabupaten di Jawa Timur
  KabModel("Surabaya", calculateSuaraKabupaten("Surabaya"), 10, "Jawa Timur"),
  KabModel("Malang", calculateSuaraKabupaten("Malang"), 11, "Jawa Timur"),
  // Kabupaten di Jawa Barat
  KabModel("Bandung", calculateSuaraKabupaten("Bandung"), 12, "Jawa Barat"),
  // Kabupaten di Banten
  KabModel("Tangerang Selatan", calculateSuaraKabupaten("Tangerang Selatan"), 13, "Banten"),
  KabModel("Tangerang", calculateSuaraKabupaten("Tangerang"), 14, "Banten"),
  // Kabupaten di DIY
  KabModel("Yogyakarta", calculateSuaraKabupaten("Yogyakarta"), 15, "DIY"),
];

int calculateSuaraProvinsi(String provinsi) {
  return kabupaten
      .where((kab) => kab.provinsi == provinsi)
      .fold(0, (sum, kab) => sum + kab.suara!);
}

List<ProvinsiModel> provinsi = [
  ProvinsiModel("Jawa Tengah", calculateSuaraProvinsi("Jawa Tengah"), 1),
  ProvinsiModel("Jawa Timur", calculateSuaraProvinsi("Jawa Timur"), 2),
  ProvinsiModel("Jawa Barat", calculateSuaraProvinsi("Jawa Barat"), 3),
  ProvinsiModel("Banten", calculateSuaraProvinsi("Banten"), 4),
  ProvinsiModel("DIY", calculateSuaraProvinsi("DIY"), 5),
];
