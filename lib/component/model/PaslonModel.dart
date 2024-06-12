import 'package:mapvotersapk/component/model/PartaiModel.dart';
import 'package:mapvotersapk/component/model/UserMode.dart';

class PaslonModel{
  int? id;
  String? foto;
  String? nomorUrut;
  String? dapil;
  PartaiModel? partai;
  UserModel? user;

  PaslonModel({
    this.id,
    this.foto,
    this.nomorUrut,
    this.dapil,
    this.partai,
    this.user,
  });
  PaslonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];
    nomorUrut = json['nomor_urut'];
    dapil = json['dapil'];
    partai = json['partai'] != null ? new PartaiModel.fromJson(json['partai']) : null;
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foto'] = this.foto;
    data['nomor_urut'] = this.nomorUrut;
    data['dapil'] = this.dapil;
    if (this.partai != null) {
      data['partai_id'] = this.partai!.toJson();
    }
    if (this.user != null) {
      data['user_id'] = this.user!.toJson();
    }
    return data;
  }
}



