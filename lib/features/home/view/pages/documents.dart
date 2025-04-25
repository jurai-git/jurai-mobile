import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/demandas_view_button.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';

class Documents extends ConsumerStatefulWidget {
  const Documents({super.key});

  @override
  ConsumerState<Documents> createState() => _DocumentsState();
}

var demandasList;
var currentDemanda;
int buttonIndex = 0;

enum Options{ general, ement }

class _DocumentsState extends ConsumerState<Documents>{ 

  @override
  void initState() {
    super.initState();
    demandasList = loadDemandas(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    currentDemanda = ref.watch(demandaProvider);
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
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.amber,
                      ),
                      child: SvgPicture.asset("img/profile.svg"),
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
                          "Documentos",
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
              currentDemanda == null ? Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: FutureBuilder<List<Widget>>(
                  future: demandasList,
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
                      return Text('Não foram encontradas demandas!', style: TextStyle(color: Colors.white),);
                    }
                  },
                ),
              )
              :
              Column(
                spacing: 30,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: const Color.fromRGBO(255, 255, 255, .1)), bottom: BorderSide(color: const Color.fromRGBO(255, 255, 255, .1))),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      child: Row(
                        spacing: 15,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            padding: EdgeInsets.all(20),
                            child: SvgPicture.asset("img/profile.svg"),
                          ),
                          Text("teste", style: TextStyle(color: Colors.white, fontSize: 20)),
                        ]
                      ),
                    )
                  ),
                  Padding( 
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      spacing: 30,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChoice(
                            onSelectionChanged: (value) {
                              setState(() {
                                buttonIndex = value - 1;
                              });
                            },
                          ),
                        ),
                        if (buttonIndex == 0) 
                          Column(
                            spacing: 30,
                            children: [
                              TopicInformation(topicName: "Foro", topicData: currentDemanda.foro, topicImage: "img/foro.svg"),
                              TopicInformation(topicName: "Status", topicData: currentDemanda.status, topicImage: "img/status.svg"),
                              TopicInformation(topicName: "Competência", topicData: currentDemanda.competencia, topicImage: "img/competencia.svg"),
                              TopicInformation(topicName: "Classe", topicData: currentDemanda.classe, topicImage: "img/classe.svg"),
                            ],
                          ),
                        if (buttonIndex == 1) 
                          Column(
                            spacing: 30,
                            children: [
                              TopicInformation(topicName: "Assunto Principal", topicData: currentDemanda.assunto_principal, topicImage: "img/assuntoPrincipal.svg"),
                              TopicInformation(topicName: "Valor da Ação", topicData: currentDemanda.valor_acao, topicImage: "img/valorAcao.svg"),
                            ],
                          ),
                      ]
                    ),
                  )
                ],
              )
            ]
          )
        )
      )
    );
  }
}

Future<List<Widget>> loadDemandas(BuildContext context, WidgetRef ref) async{
  var lista = <Widget>[];
  int count = 1;
  demandasList = ref.read(demandaListProvider);

  for (Demanda d in demandasList) {
    lista.add(DemandasViewButton(demanda: d, ref: ref, count: count,));
    count++;
  }
  print(lista);
  
  return lista;
}

class SingleChoice extends StatelessWidget {
  final Function(int) onSelectionChanged;
  const SingleChoice({super.key, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Options>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        backgroundColor: Color.fromRGBO(25, 24, 29, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, .5),
        selectedBackgroundColor: Colors.blue,
        selectedForegroundColor: Colors.white,
        side: BorderSide(color: Colors.transparent, width: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        textStyle: TextStyle(fontWeight: FontWeight.w400),
      ),
      segments: const <ButtonSegment<Options>>[
        ButtonSegment<Options>(value: Options.general, label: Text('Gerais')),
        ButtonSegment<Options>(value: Options.ement, label: Text('Ementa')),
      ],
      selected: <Options>{Options.values[buttonIndex]},
      onSelectionChanged: (Set<Options> newSelection) {
        Options selectedOption = newSelection.first;
        int selectedValue = selectedOption == Options.general ? 1 : 2;
        onSelectionChanged(selectedValue);
      },
    );
  }
}