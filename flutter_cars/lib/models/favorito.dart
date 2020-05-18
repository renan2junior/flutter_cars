import 'dart:convert';

import 'package:flutter_cars/models/entity.dart';

class Favorito extends Entity {

  int id;
  String nome;
  
  Favorito({
    this.id,
    this.nome,
  });


  Favorito copyWith({
    int id,
    String nome,
  }) {
    return Favorito(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  static Favorito fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Favorito(
      id: map['id'],
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  static Favorito fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Favorito(id: $id, nome: $nome)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Favorito &&
      o.id == id &&
      o.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
