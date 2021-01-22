import 'dart:convert';

import 'package:meta/meta.dart';

class AdressModel {
  String cep;
  String state;
  String city;
  String neighborhood;
  String adress;
  String number;
  String complement;
  AdressModel({
    @required this.cep,
    this.state,
    this.city,
    this.neighborhood,
    this.adress,
    this.number,
    this.complement,
  });

  AdressModel copyWith({
    String cep,
    String state,
    String city,
    String neighborhood,
    String adress,
    String number,
    String complement,
  }) {
    return AdressModel(
      cep: cep ?? this.cep,
      state: state ?? this.state,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      adress: adress ?? this.adress,
      number: number ?? this.number,
      complement: complement ?? this.complement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'state': state,
      'city': city,
      'neighborhood': neighborhood,
      'adress': adress,
      'number': number,
      'complement': complement,
    };
  }

  factory AdressModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AdressModel(
      cep: map['cep'],
      state: map['state'],
      city: map['city'],
      neighborhood: map['neighborhood'],
      adress: map['adress'],
      number: map['number'],
      complement: map['complement'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AdressModel.fromJson(String source) =>
      AdressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CEP: $cep\nCidade: $city/$state\nBairro: $neighborhood\nLogradouro: $adress';
  }
}
