import 'dart:convert';

class Advogado{
  final int id;
  final String nome;
  final String email;
  final String oab;
  final String accessToken;

  Advogado({required this.id, required this.nome, required this.email, required this.oab, required this.accessToken});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
      'oab': oab,
      'accessToken': accessToken
    };
  }

  factory Advogado.fromMap(Map<String, dynamic> map){
    return Advogado(id: map['id'], nome: map['nome'], email: map['email'], oab: map['oab'], accessToken: map['accessToken']);
  }

  String toJson() => json.encode(toMap());

  factory Advogado.fromJson(String source) =>
    Advogado.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  String toString(){
    return 'Advogado(id: $id, nome: $nome, email: $email, oab: $oab, accessToken: $accessToken)';
  }
}