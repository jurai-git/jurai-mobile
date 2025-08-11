import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
import 'package:jurai/features/home/view/widgets/profile_card.dart';


class Devs extends ConsumerStatefulWidget {
  const Devs({super.key});

  @override
  ConsumerState<Devs> createState() => _DevsState();
}

class _DevsState extends ConsumerState<Devs>{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        appBar: AppBar(title: Text("Desenvolvedores", style: TextStyle(color: Colors.white)), centerTitle: true, iconTheme: IconThemeData(color: Color(0xFF387FB9)), backgroundColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView( 
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
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
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
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
    ProfileCard(profileName: "Wendel Frota", profilePictureUrl: "https://avatars.githubusercontent.com/u/132313694?v=4", profileRole: "AI Developer"),
    ProfileCard(profileName: "Mateus Daroz", profilePictureUrl: "https://avatars.githubusercontent.com/u/143561347?v=4", profileRole: "Mobile Developer"),
    ProfileCard(profileName: "Lucas Bachega", profilePictureUrl: "https://media.licdn.com/dms/image/v2/D4D03AQGAZKqNA_krAQ/profile-displayphoto-shrink_800_800/B4DZbHEaC5G4Ac-/0/1747096543981?e=1754524800&v=beta&t=-jgeuE-i3PUdhBw4MpYK4RaKQP0-oqYqkSHjRQerh8Y", profileRole: "Web Developer"),
    ProfileCard(profileName: "Miguel Vale", profilePictureUrl: "https://media.licdn.com/dms/image/v2/D4D03AQGt8uCAOgyx-A/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1715478655603?e=1754524800&v=beta&t=BIN0LTib-yKrR_j_acRFgJstW8R5kVRnvUcwGCBadDM", profileRole: "Desktop Developer"),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          options: CarouselOptions(
            height: 350.0,
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
          items: imgList.map((item) => Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 32, 31, 36), Color.fromARGB(255, 32, 31, 36), Color.fromRGBO(12, 58, 96, 1),],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: item,
            )
          )
              ).toList(),
        );
  }
}
