import 'dart:convert';

import 'package:flutter_cars/models/entity.dart';

class Carro extends Entity<Carro> {
  int id;
  String nome;
  String tipo;
  String descricao;
  String urlFoto;
  String urlVideo;
  String latitude;
  String longitude;
  Carro({
    this.id,
    this.nome,
    this.tipo,
    this.descricao,
    this.urlFoto,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });




  Carro copyWith({
    int id,
    String nome,
    String tipo,
    String descricao,
    String urlFoto,
    String urlVideo,
    String latitude,
    String longitude,
  }) {
    return Carro(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      descricao: descricao ?? this.descricao,
      urlFoto: urlFoto ?? this.urlFoto,
      urlVideo: urlVideo ?? this.urlVideo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'descricao': descricao,
      'urlFoto': urlFoto,
      'urlVideo': urlVideo,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Carro fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Carro(
      id: map['id'],
      nome: map['nome'],
      tipo: map['tipo'],
      descricao: map['descricao'],
      urlFoto: map['urlFoto'],
      urlVideo: map['urlVideo'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  static Carro fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Carro(id: $id, nome: $nome, tipo: $tipo, descricao: $descricao, urlFoto: $urlFoto, urlVideo: $urlVideo, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Carro &&
      o.id == id &&
      o.nome == nome &&
      o.tipo == tipo &&
      o.descricao == descricao &&
      o.urlFoto == urlFoto &&
      o.urlVideo == urlVideo &&
      o.latitude == latitude &&
      o.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nome.hashCode ^
      tipo.hashCode ^
      descricao.hashCode ^
      urlFoto.hashCode ^
      urlVideo.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}
