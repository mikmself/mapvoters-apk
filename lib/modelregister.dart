import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class modelRegis {
  BuildContext context;
  String nama = "";
  String email = "";
  int noHP = 0;
  String password = "";
  String type = "";
  int noUrut = 0;
  String dapil = "";
  String partai = "";
  modelRegis(this.context, this.nama, this.email, this.noHP, this.password,
      this.type, this.noUrut, this.dapil, this.partai);
}

List<modelRegis> registrasi = [];
