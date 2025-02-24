import 'dart:io';

import 'package:flutter/material.dart';

class Devs extends StatelessWidget {
  const Devs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50, top: 50),
                    child: Image.asset('img/jurai-name.png', scale: 6.5),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 50, top: 50),
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.amber,
                      ),
                      child: Image.asset("img/profile.png"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                    child: Text(
                      "Sobre Nós",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
                    child: Text(
                      "O JurAI surgiu da necessidade de advogados em adquirir mais otimização nos seus escritórios de advocacia, tendo em vista que o trabalho diário de analisar inúmeros documentos processuais é um processo lento e exaustivo para os mesmos. Tendo em vista isso, o JurAI surge dessa necessidade para melhorar o desempenho do advogado, deixando a parte complexa para nosso produto, e a parte racional para o advogado, visando um bom trabalho e uma boa elaboração de documentos processuais",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: CircleAvatar(backgroundImage: NetworkImage("https://www.petz.com.br/blog/wp-content/uploads/2017/07/passarinhos-domesticos-pet.jpg")),        
                  ),
                  Container(
                    child: CircleAvatar(backgroundImage: NetworkImage("https://www.petz.com.br/blog/wp-content/uploads/2017/07/passarinhos-domesticos-pet.jpg"))
                  ),
                  Container(
                    child: CircleAvatar(backgroundImage: NetworkImage("https://www.petz.com.br/blog/wp-content/uploads/2017/07/passarinhos-domesticos-pet.jpg"))
                  ),
                  Container(
                    child: CircleAvatar(backgroundImage: NetworkImage("https://www.petz.com.br/blog/wp-content/uploads/2017/07/passarinhos-domesticos-pet.jpg"))
                  ),
                ],
              )
            ]
          )
        )
      )
    );
  }
}