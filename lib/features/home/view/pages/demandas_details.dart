import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/demandas_information.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';

class DemandasDetails extends ConsumerStatefulWidget {
  final Demanda demanda;
  const DemandasDetails({super.key, required this.demanda});

  @override
  ConsumerState<DemandasDetails> createState() => _DemandasDetailsState();
}

class _DemandasDetailsState extends ConsumerState<DemandasDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
        appBar: AppBar(
          title: Text("Informações da Demanda", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF387FB9)),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(60),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Icon(Icons.description, color: Colors.white,)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Informações Gerais", style: TextStyle(color: Colors.white, fontSize: 22),),
                    ]
                  ),

                  TopicInformation(topicName: "Identificação", topicData: widget.demanda.identificacao, topicImage: "img/profile.svg", first: true,),
                  TopicInformation(topicName: "Foro", topicData: widget.demanda.foro, topicImage: "img/foro.svg"),
                  TopicInformation(topicName: "Status", topicData: widget.demanda.status, topicImage: "img/status.svg"),
                  TopicInformation(topicName: "Competência", topicData: widget.demanda.competencia, topicImage: "img/competencia.svg"),
                  TopicInformation(topicName: "Classe", topicData: widget.demanda.classe, topicImage: "img/classe.svg"),
                  TopicInformation(topicName: "Assunto Principal", topicData: widget.demanda.assunto_principal, topicImage: "img/assuntoPrincipal.svg"),
                  TopicInformation(topicName: "Valor da Ação", topicData: widget.demanda.valor_acao.toString(), topicImage: "img/valorAcao.svg"),
                ],
              ),
          ),
        ),
        )
    );
  }
}