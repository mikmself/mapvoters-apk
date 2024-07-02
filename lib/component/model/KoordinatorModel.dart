import 'package:mapvotersapk/component/model/PaslonModel.dart';
import 'package:mapvotersapk/component/model/UserMode.dart';

class KoordinatorModel {
  dynamic id;
  String? nik;
  String? foto;
  PaslonModel? paslon;
  UserModel? user;

  KoordinatorModel({
    this.id,
    this.nik,
    this.foto,
    this.paslon,
    this.user,
  });

  KoordinatorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    foto = json['foto'];
    paslon = json['paslon'] != null ? new PaslonModel.fromJson(json['paslon']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['foto'] = this.foto;
    if(this.paslon != null) {
      data['paslon_id'] = this.paslon!.id;
    }
    if(this.user != null) {
      data['user_id'] = this.user!.id;
    }
    return data;
  }
}