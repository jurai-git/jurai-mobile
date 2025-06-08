import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/requerentes_view_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Clients extends ConsumerStatefulWidget {
  const Clients({super.key});

  @override
  ConsumerState<Clients> createState() => _ClientsState();
}

late var finalList;
late var currentRequerente;
int buttonIndex = 0;
enum Options { personal, general, adress }

class _ClientsState extends ConsumerState<Clients> {
  bool isLoading=true;

  @override
  Widget build(BuildContext context) { 
    final requerenteListAsync = ref.watch(requerenteListProvider);
    currentRequerente = ref.watch(requerenteProvider);

    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
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
                        backgroundColor: Colors.blue,
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
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: requerenteListAsync.when(
                    data: (requerentes) {
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        if(isLoading){
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                      if (requerentes.isEmpty) {
                        return const Text(
                          'Você não possui requerentes associados!',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Column(
                        children: requerentes.asMap().entries.map((entry) {
                          return RequerentesViewButton(
                            requerente: entry.value,
                            ref: ref,
                          );
                        }).toList(),
                      );
                    
                    },
                    loading: () {
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        if(!isLoading){
                          setState(() {
                            isLoading = true;
                          });
                        }
                      });

                      return Skeletonizer(
                      enabled: true,
                      enableSwitchAnimation: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (MediaQuery.of(context).size.height/200).toInt(),
                        itemBuilder: (context, index) {
                          return RequerentesViewButton(requerente: Requerente.f(), ref: ref);
                        },
                      ),
                    );
                  },
                    error: (error, stack) => Text(
                      'Error: $error',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}