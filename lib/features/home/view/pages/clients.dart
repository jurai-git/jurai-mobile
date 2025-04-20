import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/repositories/home_remote_repository.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/requerentes_view_button.dart';
import 'package:jurai/features/home/viewmodel/home_viewmodel.dart';

class Clients extends ConsumerStatefulWidget {
  const Clients({super.key});

  @override
  ConsumerState<Clients> createState() => _ClientsState();
}

late var requerentesList;
late var finalList;

class _ClientsState extends ConsumerState<Clients> {
  
  @override
  void initState() {
    super.initState();
    finalList = loadRequerentes(context, ref);
  }

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
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Widget>> loadRequerentes(BuildContext context, WidgetRef ref) async{
  var lista = <Widget>[];

  requerentesList = await ref.read(homeViewModelProvider.notifier).getAllRequerentes();

  for (Requerente r in requerentesList) {
    lista.add(RequerentesViewButton(name: r.nome));
  }
  print(lista);
  
  return lista;
}
