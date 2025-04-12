import 'dart:convert';

class Advogado{
  final String id;
  final String username;
  final String email;
  final String oab;
  final String accessToken;

  Advogado({required this.id, required this.username, required this.email, required this.oab, required this.accessToken});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'oab': oab,
      'accessToken': accessToken
    };
  }

  Advogado copyWith({
    String? id,
    String? username,
    String? email,
    String? oab,
    String? accessToken,
  }){
    return Advogado(id: id ?? this.id, username: username ?? this.username, email: email ?? this.email, oab: oab ?? this.oab, accessToken: accessToken ?? this.accessToken);
  }

  factory Advogado.fromMap(Map<String, dynamic> map){
    return Advogado(id: map['id'].toString(), username: map['username'] ?? '', email: map['email'] ?? '', oab: map['oab'] ?? '', accessToken: map['accessToken'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Advogado.fromJson(String source) =>
    Advogado.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  String toString(){
    return 'Advogado(id: $id, username: $username, email: $email, oab: $oab, accessToken: $accessToken)';
  }
}