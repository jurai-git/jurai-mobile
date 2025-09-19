import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jurai/features/auth/models/advogado.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';

class ProfileDetails extends StatelessWidget {
  final Advogado? advogado;

  const ProfileDetails({super.key, required this.advogado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
      appBar: AppBar(
          title: Text("Perfil", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF387FB9)),
          backgroundColor: Colors.transparent,
        ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: ClipOval(
                      child: Image.network(
                        "http://127.0.0.1:5001/advogado/${advogado!.id.toString()}/pfp",
                        width: 100, 
                        height: 100, 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(advogado!.username, style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 30,),
              TopicInformation(topicName: "Nome do advogado", topicData: advogado!.username, topicImage: null),
              TopicInformation(topicName: "Nº OAB", topicData: advogado!.oab, topicImage: null),
              TopicInformation(topicName: "Email", topicData: advogado!.email, topicImage: null)
            ],
          ),
        ),
      )
    );
  }
}