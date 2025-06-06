import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';

class ClientsInformation extends ConsumerStatefulWidget {
  final Requerente requerente;
  const ClientsInformation({super.key, required this.requerente});

  @override
  ConsumerState<ClientsInformation> createState() => _ClientsInformationState();
}

class _ClientsInformationState extends ConsumerState<ClientsInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
        appBar: AppBar(
          title: Text("Informações do Requerente", style: TextStyle(color: Colors.white),),
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
                    child: SvgPicture.asset("img/profile.svg", width: 65,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Informações Pessoais", style: TextStyle(color: Colors.white, fontSize: 22),),
                    ]
                  ),
                  
                  TopicInformation(topicName: "Nome Completo  ", topicData: widget.requerente.nome, topicImage: "img/profile.svg", first: true,),
                  TopicInformation(topicName: "Nome Social", topicData: widget.requerente.nomeSocial!= '' ? widget.requerente.nomeSocial : "Não possui", topicImage: "img/profile.svg"),
                  TopicInformation(topicName: "Email", topicData: widget.requerente.email, topicImage: "img/email.svg",),
                  TopicInformation(topicName: "Gênero", topicData: widget.requerente.genero, topicImage: "img/profile.svg",),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Informações Gerais", style: TextStyle(color: Colors.white, fontSize: 22),),
                    ]
                  ),

                  TopicInformation(topicName: "CPF/CNPJ", topicData: widget.requerente.cpf_cnpj, topicImage: "img/oab.svg", first: true,),
                  TopicInformation(topicName: "RG", topicData: widget.requerente.rg, topicImage: "img/rg.svg",),
                  TopicInformation(topicName: "Profissão", topicData: widget.requerente.profissao, topicImage: "img/job.svg",),
                  TopicInformation(topicName: "Nacionalidade", topicData: widget.requerente.nacionalidade, topicImage: "img/nationality.svg",),
                  TopicInformation(topicName: "Estado Civil", topicData: widget.requerente.estadoCivil, topicImage: "img/civil.svg",),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Informações de Endereço", style: TextStyle(color: Colors.white, fontSize: 22),),
                    ]
                  ),

                  TopicInformation(topicName: "CEP", topicData: widget.requerente.cep, topicImage: "img/cep.svg", first: true,),
                  TopicInformation(topicName: "Cidade", topicData: widget.requerente.cidade, topicImage: "img/city.svg",),
                  TopicInformation(topicName: "Bairro", topicData: widget.requerente.bairro, topicImage: "img/bairro.svg",),
                  TopicInformation(topicName: "Logradouro", topicData: widget.requerente.logradouro, topicImage: "img/nationality.svg",),
                  TopicInformation(topicName: "Nº", topicData: widget.requerente.estadoCivil, topicImage: "img/number.svg",),
                  TopicInformation(topicName: "Complemento", topicData: widget.requerente.complemento!= '' ? widget.requerente.complemento : 'Não possui', topicImage: "img/complement.svg",),
                ],
              ),
          ),
        ),
        )
    );
  }
}