import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/demandas_view_button.dart';

class Documents extends ConsumerStatefulWidget {
  const Documents({super.key});

  @override
  ConsumerState<Documents> createState() => _DocumentsState();
}

var demandasList;
var currentDemanda;

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