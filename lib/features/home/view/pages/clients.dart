import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';
import 'package:jurai/features/home/view/widgets/requerentes_view_button.dart';

class Clients extends ConsumerStatefulWidget {
  const Clients({super.key});

  @override
  ConsumerState<Clients> createState() => _ClientsState();
}

late var requerentesList;
late var finalList;
late var currentRequerente;
int buttonIndex = 0;
enum Options { personal, general, adress }

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
                    margin: EdgeInsets.only(left: 25, top: 50),
                    child: Image.asset('img/jurai-name.png', scale: 6.5),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 25, top: 50),
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
                      child: SvgPicture.asset("img/profile.svg"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 50, 25, 20),
                    child: Row(
                      children: [
                        currentRequerente != null ? IconButton(onPressed: (){setState((){ref.watch(requerenteProvider.notifier).clear(); ref.watch(demandaListProvider.notifier).clear(); ref.watch(demandaProvider.notifier).clear(); buttonIndex=0;});}, icon: Icon(Icons.arrow_back, color: Colors.white, size: 40,)) : Text(''),
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
                padding: EdgeInsets.symmetric(horizontal: 25),
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
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                          Text(currentRequerente.nome, style: TextStyle(color: Colors.white, fontSize: 20)),
                        ]
                      ),
                    )
                  ),
                  Padding( 
                    padding: EdgeInsets.symmetric(horizontal: 25),
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: SingleChildScrollView(
                            child: (){
                              if (buttonIndex == 0) {
                                return Column(
                                  spacing: 30,
                                  children: [
                                    TopicInformation(topicName: "Nome Social", topicData: currentRequerente.nomeSocial!= '' ? currentRequerente.nomeSocial : "Não possui", topicImage: "img/profile.svg",),
                                    TopicInformation(topicName: "Email", topicData: currentRequerente.email, topicImage: "img/email.svg",),
                                    TopicInformation(topicName: "Gênero", topicData: currentRequerente.genero, topicImage: "img/profile.svg",),
                                  ],
                                );
                              }
                              if (buttonIndex == 1) {
                                return Column(
                                  spacing: 30,
                                  children: [
                                    TopicInformation(topicName: "CPF/CNPJ", topicData: currentRequerente.cpf_cnpj, topicImage: "img/oab.svg",),
                                    TopicInformation(topicName: "RG", topicData: currentRequerente.rg, topicImage: "img/rg.svg",),
                                    TopicInformation(topicName: "Profissão", topicData: currentRequerente.profissao, topicImage: "img/job.svg",),
                                    TopicInformation(topicName: "Nacionalidade", topicData: currentRequerente.nacionalidade, topicImage: "img/nationality.svg",),
                                    TopicInformation(topicName: "Estado Civil", topicData: currentRequerente.estadoCivil, topicImage: "img/civil.svg",),
                                  ],
                                );
                              }
                              if (buttonIndex == 2) {
                                return Column(
                                  spacing: 30,
                                  children: [
                                    TopicInformation(topicName: "CEP", topicData: currentRequerente.cep, topicImage: "img/cep.svg",),
                                    TopicInformation(topicName: "Cidade", topicData: currentRequerente.cidade, topicImage: "img/city.svg",),
                                    TopicInformation(topicName: "Bairro", topicData: currentRequerente.bairro, topicImage: "img/bairro.svg",),
                                    TopicInformation(topicName: "Logradouro", topicData: currentRequerente.logradouro, topicImage: "img/nationality.svg",),
                                    TopicInformation(topicName: "Nº", topicData: currentRequerente.estadoCivil, topicImage: "img/number.svg",),
                                    TopicInformation(topicName: "Complemento", topicData: currentRequerente.complemento!= '' ? currentRequerente.complemento : 'Não possui', topicImage: "img/complement.svg",),
                                  ],
                                );
                              }
                            }()
                          )
                        )
                      ]
                    ),
                  )
                ],
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
        ButtonSegment<Options>(value: Options.personal, label: Text('Pessoais')),
        ButtonSegment<Options>(value: Options.general, label: Text('Gerais')),
        ButtonSegment<Options>(value: Options.adress, label: Text('Endereço')),
      ],
      selected: <Options>{Options.values[buttonIndex]},
      onSelectionChanged: (Set<Options> newSelection) {
        Options selectedOption = newSelection.first;
        int selectedValue;
        if(selectedOption == Options.personal)
          selectedValue = 1;
        else if (selectedOption == Options.general)
          selectedValue = 2;
        else
          selectedValue = 3;
        onSelectionChanged(selectedValue);
      },
    );
  }
}