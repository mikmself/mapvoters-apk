class SettingModel {
  int targetSuara;

  SettingModel({required this.targetSuara});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      targetSuara: json['target_suara'] ?? 0,
    );
  }
}
