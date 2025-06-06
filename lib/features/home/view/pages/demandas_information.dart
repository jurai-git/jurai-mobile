import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/view/widgets/demandas_view_button.dart';

class DemandasInformation extends ConsumerStatefulWidget {
  const DemandasInformation({super.key});

  @override
  ConsumerState<DemandasInformation> createState() => _DemandasInformationState();
}

class _DemandasInformationState extends ConsumerState<DemandasInformation> {
  @override
  Widget build(BuildContext context) {
    final demandas = ref.watch(demandaListProvider);

    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
        appBar: AppBar(
          title: Text("Lista de Demandas", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF387FB9)),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: FutureBuilder<List<Widget>>(
                    future: loadDemandas(context, ref, demandas),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4-100), child: LoadingCircle());
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white),);
                      }
                      if (snapshot.hasData) {
                        if(snapshot.data!.isEmpty){
                          return Text('O requerente selecionado não possui demandas!', style: TextStyle(color: Colors.white),);
                        }
                        return Column(
                        spacing: 15,
                          children: snapshot.data!,
                        );
                      } 
                        return Text('Não foram encontradas demandas!', style: TextStyle(color: Colors.white),);
                      
                    },
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}

Future<List<Widget>> loadDemandas(BuildContext context, WidgetRef ref, List<Demanda> demandas) async{
  var lista = <Widget>[];
  int count = 1;

  for (Demanda d in demandas) {
    lista.add(DemandasViewButton(demanda: d, ref: ref, count: count,));
    count++;
  }
  print(lista);
  
  return lista;
}