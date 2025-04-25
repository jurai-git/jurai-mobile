import 'dart:convert';

class Demanda {
  final int id;
  final String identificacao;
  final String foro;
  final String status;
  final String competencia;
  final String classe;
  final String assunto_principal;
  final bool pedido_liminar;
  final bool segredo_justica;
  final double valor_acao;
  final bool dispensa_legal;
  final bool justica_gratuita;
  final bool guia_custas;
  final String resumo;

  Demanda({required this.id, required this.identificacao, required this.foro, required this.status, required this.competencia, required this.classe, required this.assunto_principal, required this.pedido_liminar, required this.segredo_justica, required this.valor_acao, required this.dispensa_legal, required this.justica_gratuita, required this.guia_custas, required this.resumo});

  Demanda copyWith({
    int? id,
    String? identificacao,
    String? foro,
    String? status,
    String? competencia,
    String? classe,
    String? assunto_principal,
    bool? pedido_liminar,
    bool? segredo_justica,
    double? valor_acao,
    bool? dispensa_legal,
    bool? justica_gratuita,
    bool? guia_custas,
    String? resumo,
  }) {
    return Demanda(id: id ?? this.id, identificacao: identificacao ?? this.identificacao, foro: foro ?? this.foro, status: status ?? this.status, competencia: competencia ?? this.competencia, classe: classe ?? this.classe, assunto_principal: assunto_principal ?? this.assunto_principal, pedido_liminar: pedido_liminar ?? this.pedido_liminar, segredo_justica: segredo_justica ?? this.segredo_justica, valor_acao: valor_acao ?? this.valor_acao, dispensa_legal: dispensa_legal ?? this.dispensa_legal, justica_gratuita: justica_gratuita ?? this.justica_gratuita, guia_custas: guia_custas ?? this.guia_custas, resumo: resumo ?? this.resumo);
  } 

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'identificacao': identificacao,
      'foro': foro,
      'competencia': competencia,
      'assunto_principal': assunto_principal,
      'pedido_liminar': pedido_liminar,
      'segredo_justica': segredo_justica,
      'valor_acao': valor_acao,
      'dispensa_legal': dispensa_legal,
      'justica_gratuita': justica_gratuita,
      'guia_custas': guia_custas,
      'status': status,
      'resumo': resumo,
    };
  }

  factory Demanda.fromMap(Map<String, dynamic> map){
    return Demanda(id: map['id'] ?? '', identificacao: map['identificacao'] ?? '', foro: map['foro'] ?? '', status: map['status'] ?? '', competencia: map['competencia'] ?? '', classe: map['classe'] ?? '', assunto_principal: map['assunto_principal'] ?? '', pedido_liminar: map['pedido_liminar'] ?? '', segredo_justica: map['segredo_justica'] ?? '', valor_acao: map['valor_acao'] ?? '', dispensa_legal: map['dispensa_legal'] ?? '', justica_gratuita: map['justica_gratuita'] ?? '', guia_custas: map['guia_custas'] ?? '', resumo: map['resumo'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Demanda.fromJson(String source) =>
    Demanda.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  String toString(){
    return 'Demanda(id: $id, identificacao: $identificacao, foro: $foro, status: $status, competencia: $competencia, classe: $classe, assunto_principal: $assunto_principal, pedido_liminar: $pedido_liminar, segredo_justica: $segredo_justica, valor_acao: $valor_acao, dispensa_legal: $dispensa_legal, justica_gratuita: $justica_gratuita, guia_custas: $guia_custas, resumo: $resumo)';
  }
}