import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/profile_card.dart';


class Devs extends StatelessWidget {
  const Devs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView( 
        child: Center(
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
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));},
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
                    child: Row(
                      children: [
                        Text(
                          "Sobre ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Text(
                          "Nós",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
              CarouselWithSnap(),
              Container(
                margin: EdgeInsets.only(top: 20),
              )
            ]
          )
        )
      )
      )
    );
  }
}

class CarouselWithSnap extends StatelessWidget {
  CarouselWithSnap({super.key});
  
  final List<ProfileCard> imgList = [
    ProfileCard(profileName: "Wendel Frota", profilePictureUrl: "https://avatars.githubusercontent.com/u/132313694?v=4", profileAge: "17"),
    ProfileCard(profileName: "Mateus Daroz", profilePictureUrl: "https://avatars.githubusercontent.com/u/143561347?v=4", profileAge: "18"),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          options: CarouselOptions(
            height: 430.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.7,
            enlargeFactor: 0,
            aspectRatio: 1/1,
            initialPage: 0,
            pageSnapping: true,
          ),
          items: imgList.map((item) => Stack(
            children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                    color: Color.fromARGB(255, 32, 31, 36),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 125,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),),
                      color: Color(0xFF387FB9),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                    child: item,
                  ),
                  
              ]
              )
              ).toList(),
        );
  }
}
