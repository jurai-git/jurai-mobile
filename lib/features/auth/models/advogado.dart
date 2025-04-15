import 'dart:convert';

class Advogado{
  final String id;
  final String username;
  final String email;
  final String oab;
  final String access_token;

  Advogado({required this.id, required this.username, required this.email, required this.oab, required this.access_token});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'oab': oab,
      'access_token': access_token
    };
  }

  Advogado copyWith({
    String? id,
    String? username,
    String? email,
    String? oab,
    String? access_token,
  }){
    return Advogado(id: id ?? this.id, username: username ?? this.username, email: email ?? this.email, oab: oab ?? this.oab, access_token: access_token ?? this.access_token);
  }

  factory Advogado.fromMap(Map<String, dynamic> map){
    return Advogado(id: map['id'].toString(), username: map['username'] ?? '', email: map['email'] ?? '', oab: map['oab'] ?? '', access_token: map['access_token'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Advogado.fromJson(String source) =>
    Advogado.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  String toString(){
    return 'Advogado(id: $id, username: $username, email: $email, oab: $oab, access_token: $access_token)';
  }
}