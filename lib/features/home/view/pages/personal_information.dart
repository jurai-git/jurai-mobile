import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Informações Pessoais"), 
          centerTitle: true
        ),
        body: Center(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
