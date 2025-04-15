import 'dart:convert';

class Requerente {
  final String nome;
  final String nomeSocial;
  final String email;
  final String genero;
  final String cpf_cnpj;
  final bool idoso;
  final String rg;
  final String orgaoEmissor;
  final String estadoCivil;
  final String nacionalidade;
  final String profissao;
  final String cep;
  final String logradouro;
  final String numImovel;
  final String complemento;
  final String bairro;
  final String estado;
  final String cidade;

  Requerente({required this.nome, required this.nomeSocial, required this.email, required this.genero, required this.cpf_cnpj, required this.idoso, required this.rg, required this.orgaoEmissor, required this.estadoCivil, required this.nacionalidade, required this.profissao, required this.cep, required this.logradouro, required this.numImovel, required this.complemento, required this.bairro, required this.estado, required this.cidade});

  Requerente copyWith({
    String? nome,
    String? nomeSocial,
    String? email,
    String? genero,
    String? cpf_cnpj,
    bool? idoso,
    String? rg,
    String? orgaoEmissor,
    String? estadoCivil,
    String? nacionalidade,
    String? profissao,
    String? cep,
    String? logradouro,
    String? numImovel,
    String? complemento,
    String? bairro,
    String? estado,
    String? cidade
  }) {
    return Requerente(nome: nome ?? this.nome, nomeSocial: nomeSocial ?? this.nomeSocial, email: email ?? this.email, genero: genero ?? this.genero, cpf_cnpj: cpf_cnpj ?? this.cpf_cnpj, idoso: idoso ?? this.idoso, rg: rg ?? this.rg, orgaoEmissor: orgaoEmissor ?? this.orgaoEmissor, estadoCivil: estadoCivil ?? this.estadoCivil, nacionalidade: nacionalidade ?? this.nacionalidade, profissao: profissao ?? this.profissao, cep: cep ?? this.cep, logradouro: logradouro ?? this.logradouro, numImovel: numImovel ?? this.numImovel, complemento: complemento ?? this.complemento, bairro: bairro ?? this.bairro, estado: estado ?? this.estado, cidade: cidade ?? this.cidade);
  } 

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'nome': nome,
      'nome_social': nomeSocial,
      'genero': genero,
      'idoso': idoso,
      'rg': rg,
      'orgao_emissor': orgaoEmissor,
      'estado_civil': estadoCivil,
      'nacionalidade': nacionalidade,
      'profissao': profissao,
      'cep': cep,
      'logradouro': logradouro,
      'email': email,
      'num_imovel': numImovel,
      'complemento': complemento,
      'estado': estado,
      'cidade': cidade,
      'bairro': bairro,
    };
  }

  factory Requerente.fromMap(Map<String, dynamic> map){
    return Requerente(nome: map['nome'] ?? '', nomeSocial: map['nome_social'] ?? '', email: map['email'] ?? '', genero: map['genero'] ?? '', cpf_cnpj: map['cpf_cnpj'] ?? '', idoso: map['idoso'] ?? '', rg: map['rg'] ?? '', orgaoEmissor: map['orgao_emissor'] ?? '', estadoCivil: map['estado_civil'] ?? '', nacionalidade: map['nacionalidade'] ?? '', profissao: map['profissao'] ?? '', cep: map['cep'] ?? '', logradouro: map['logradouro'] ?? '', numImovel: map['num_imovel'] ?? '', complemento: map['complemento'] ?? '', bairro: map['bairro'] ?? '', estado: map['estado'] ?? '', cidade: map['cidade'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Requerente.fromJson(String source) =>
    Requerente.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  String toString(){
    return 'Requerente(nome: $nome, nome_social: $nomeSocial, email: $email, genero: $genero, cpf_cnpj: $cpf_cnpj, idoso: $idoso, rg: $rg, orgao_emissor: $orgaoEmissor, estado_civil: $estadoCivil, nacionalidade: $nacionalidade, profissao: $profissao, cep: $cep, logradouro: $logradouro, num_imovel: $numImovel, complemento: $complemento, bairro: $bairro, estado: $estado, cidade: $cidade)';
  }
}