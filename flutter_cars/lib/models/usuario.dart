import 'dart:convert';

import 'package:flutter/foundation.dart';

class Usuario {
  String login;
  String nome;
  String email;
  String token;
  List<String> roles;

  Usuario(
    this.login,
    this.nome,
    this.email,
    this.token,
    this.roles,
  );

  Usuario copyWith({
    String login,
    String nome,
    String email,
    String token,
    List<String> roles,
  }) {
    return Usuario(
      login ?? this.login,
      nome ?? this.nome,
      email ?? this.email,
      token ?? this.token,
      roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'nome': nome,
      'email': email,
      'token': token,
      'roles': roles,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Usuario(
      map['login'],
      map['nome'],
      map['email'],
      map['token'],
      List<String>.from(map['roles']),
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(login: $login, nome: $nome, email: $email, token: $token, roles: $roles)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Usuario &&
      o.login == login &&
      o.nome == nome &&
      o.email == email &&
      o.token == token &&
      listEquals(o.roles, roles);
  }

  @override
  int get hashCode {
    return login.hashCode ^
      nome.hashCode ^
      email.hashCode ^
      token.hashCode ^
      roles.hashCode;
  }
}
