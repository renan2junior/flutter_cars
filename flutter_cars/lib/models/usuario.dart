import 'dart:convert';

class Usuario {
  String login;
  String nome;
  String email;
  String token;
  

  Usuario(
    this.login,
    this.nome,
    this.email,
    this.token,
  );


  Usuario copyWith({
    String login,
    String nome,
    String email,
    String token,
  }) {
    return Usuario(
      login ?? this.login,
      nome ?? this.nome,
      email ?? this.email,
      token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'nome': nome,
      'email': email,
      'token': token,
    };
  }

  static Usuario fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Usuario(
      map['login'],
      map['nome'],
      map['email'],
      map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  static Usuario fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(login: $login, nome: $nome, email: $email, token: $token)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Usuario &&
      o.login == login &&
      o.nome == nome &&
      o.email == email &&
      o.token == token;
  }

  @override
  int get hashCode {
    return login.hashCode ^
      nome.hashCode ^
      email.hashCode ^
      token.hashCode;
  }
}
