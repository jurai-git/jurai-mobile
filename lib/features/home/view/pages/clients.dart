import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/repositories/home_remote_repository.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/requerentes_topic_information.dart';
import 'package:jurai/features/home/view/widgets/requerentes_view_button.dart';
import 'package:jurai/features/home/viewmodel/home_viewmodel.dart';

class Clients extends ConsumerStatefulWidget {
  const Clients({super.key});

  @override
  ConsumerState<Clients> createState() => _ClientsState();
}

late var requerentesList;
late var finalList;
late var currentRequerente;
class _ClientsState extends ConsumerState<Clients> {
  
  @override
  void initState() {
    super.initState();
    finalList = loadRequerentes(context, ref);  
  }

  @override
  Widget build(BuildContext context) { 
    currentRequerente = ref.watch(requerenteProvider);
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profile(),
                          ),
                        );
                      },
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
                          "Seus ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Text(
                          "Requerentes",
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
              currentRequerente == null ? Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: FutureBuilder<List<Widget>>(
                  future: finalList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4-100), child: LoadingCircle());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white),);
                    } else if (snapshot.hasData) {
                      return Column(
                        spacing: 15,
                        children: snapshot.data!,
                      );
                    } else {
                      return Text('Você não possui requerentes cadastrados!', style: TextStyle(color: Colors.white),);
                    }
                  },
                ),
              ) :
              Padding( 
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                spacing: 30,
                children: [
                  Row(
                    spacing: 15,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Image.asset("img/profile.png", scale: .7),
                      ),
                      Text(currentRequerente.nome, style: TextStyle(color: Colors.white, fontSize: 20)),
                      //ElevatedButton(onPressed: (){setState((){ref.watch(requerenteProvider.notifier).clear();});}, child: Text("Voltar", style: TextStyle(color: Colors.white),),),
                    ]
                    
                ),
                RequerentesTopicInformation(topicName: "Nome Social", topicData: currentRequerente.nomeSocial!= '' ? currentRequerente.nomeSocial : "Não possui", topicImage: "img/profile.png",),
                  RequerentesTopicInformation(topicName: "Email", topicData: currentRequerente.email, topicImage: "img/email.png",),
                  RequerentesTopicInformation(topicName: "Gênero", topicData: currentRequerente.genero, topicImage: "img/profile.png",),
                ]
              ),
              )
            ],
          ),
              ),
            
        ),
      );
  }
}

Future<List<Widget>> loadRequerentes(BuildContext context, WidgetRef ref) async{
  var lista = <Widget>[];

  requerentesList = ref.read(requerenteListProvider);

  for (Requerente r in requerentesList) {
    lista.add(RequerentesViewButton(requerente: r, ref: ref));
  }
  print(lista);
  
  return lista;
}
