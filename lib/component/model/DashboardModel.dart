class DashboardModel {
  final int targetSuara;
  final int totalKoordinator;
  final int totalSaksi;
  final int totalSuaraPotensial;
  final int perhitunganSuaraReal;

  DashboardModel({
    required this.targetSuara,
    required this.totalKoordinator,
    required this.totalSaksi,
    required this.totalSuaraPotensial,
    required this.perhitunganSuaraReal,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      targetSuara: json['target_suara'] ?? 0,
      totalKoordinator: json['total_koordinator'] ?? 0,
      totalSaksi: json['total_saksi'] ?? 0,
      totalSuaraPotensial: json['total_suara_potensial'] ?? 0,
      perhitunganSuaraReal: json['perhitungan_suara_real'] ?? 0,
    );
  }
}
