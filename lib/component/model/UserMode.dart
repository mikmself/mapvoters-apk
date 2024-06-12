class UserModel {
  int? id;
  String? name;
  String? email;
  String? telephone;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
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