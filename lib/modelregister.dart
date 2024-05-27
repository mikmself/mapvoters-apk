import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistrasiModel {
  BuildContext context;
  String nama = "";
  String email = "";
  int noHP = 0;
  String password = "";
  String type = "";
  int noUrut = 0;
  String dapil = "";
  String partai = "";

  RegistrasiModel(
    this.context,
    this.nama,
    this.email,
    this.noHP,
    this.password,
    this.type,
    this.noUrut,
    this.dapil,
    this.partai,
  );

  bool isValid() {
    if (nama.isEmpty) {
      return false;
    }
    if (email.isEmpty) {
      return false;
    }
    if (noHP.toStringAsExponential().isEmpty) {
      return false;
    }
    if (password.isEmpty) {
      return false;
    }
    if (type.isEmpty) {
      return false;
    }
    if (noHP.toStringAsExponential().isEmpty) {
      return false;
    }
    if (dapil.isEmpty) {
      return false;
    }
    if (partai.isEmpty) {
      return false;
    }
    return true;
  }
}

List<RegistrasiModel> registrasi = [];
