import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_cars/utils/prefs.dart';

class Usuario {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario({
    this.login,
    this.nome,
    this.email,
    this.urlFoto,
    this.token,
    this.roles,
  });

  // Criado para savar o usuário nas preferencias
  // Criado por mim.
  void save() {
    Prefs.setString("USER", this.toJson());
  }

  // Criado para recuperar o usuario.
  static Future<Usuario> get() async {
    String userString = await Prefs.getString("USER");
    Usuario user = userString.isEmpty ? null : fromJson(userString);
    return user;
  }

  // Limpar os dados do usuario nas prefs
  static void clear() {
    Prefs.setString("USER", "");
  }

  Usuario copyWith({
    String login,
    String nome,
    String email,
    String urlFoto,
    String token,
    List<String> roles,
  }) {
    return Usuario(
      login: login ?? this.login,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      urlFoto: urlFoto ?? this.urlFoto,
      token: token ?? this.token,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'nome': nome,
      'email': email,
      'urlFoto': urlFoto,
      'token': token,
      'roles': roles,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Usuario(
      login: map['login'],
      nome: map['nome'],
      email: map['email'],
      urlFoto: map['urlFoto'],
      token: map['token'],
      // roles: List<String>.from(map['roles']),
      roles: map['roles'] != null ? map['roles'].cast<String>() : null,
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Usuario &&
        o.login == login &&
        o.nome == nome &&
        o.email == email &&
        o.urlFoto == urlFoto &&
        o.token == token &&
        listEquals(o.roles, roles);
  }

  @override
  int get hashCode {
    return login.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        urlFoto.hashCode ^
        token.hashCode ^
        roles.hashCode;
  }
}
