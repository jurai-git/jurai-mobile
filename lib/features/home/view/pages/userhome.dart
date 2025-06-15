import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/recent_acess_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
import 'package:jurai/features/home/view/widgets/recent_access_requerente.dart';

class UserHome extends ConsumerStatefulWidget {
  const UserHome({super.key});

  @override
  ConsumerState<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends ConsumerState<UserHome>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final asyncList = ref.watch(recentReqAcessListProvider);
    final currentAdvogado = ref.watch(advogadoProvider);
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Nav(advogado: ref.watch(advogadoProvider),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    child: Row(
                      children: [
                        Text(
                          "Olá, ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Text(
                          currentAdvogado?.username ?? "",
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
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          "O que deseja fazer ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "hoje?",
                          style: TextStyle(
                            color: Color(0xFF387FB9),
                            fontSize: 20,
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
                    padding: EdgeInsets.only(left: 25, right: 25, top: 35, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Acessos ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Text(
                          "Recentes",
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
              SizedBox(
                height: 250,
                child: asyncList.when(
                  data: (list) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, index){
                        return RecentAccessRequerente(requerente: list[index],);
                      }
                    ); 
                  }, 
                  error: (error, stackTrace) => Text(''),
                  loading: (){
                    return null;
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}