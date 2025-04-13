import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';

class PersonalInformation extends ConsumerStatefulWidget {
  const PersonalInformation({super.key});

  @override
  ConsumerState<PersonalInformation> createState() =>
      _PersonalInformationState();
}

class _PersonalInformationState extends ConsumerState<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    final _currentAdvogado = ref.watch(advogadoProvider);
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        appBar: AppBar(title: Text("Informações Pessoais", style: TextStyle(color: Colors.white)), centerTitle: true, backgroundColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                    width: 1,
                  ),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Informações Básicas",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.5), width: 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome da Conta", style: TextStyle(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      _currentAdvogado?.username ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text("E-mail", style: TextStyle(color: Colors.grey)),
                  Text(
                    _currentAdvogado?.email ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
