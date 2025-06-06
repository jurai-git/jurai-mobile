import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/demandas_view_button.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';

class Documents extends ConsumerStatefulWidget {
  const Documents({super.key});

  @override
  ConsumerState<Documents> createState() => _DocumentsState();
}

var currentDemanda;
int buttonIndex = 0;

enum Options{ general, ement }

class _DocumentsState extends ConsumerState<Documents>{ 
  @override
  Widget build(BuildContext context) {
    currentDemanda = ref.watch(demandaProvider);
    final demandasListAsync = ref.watch(allDemandaListProvider);

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
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));},
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
                        currentDemanda != null ? IconButton(onPressed: (){setState((){ref.watch(demandaProvider.notifier).clear(); buttonIndex=0;});}, icon: Icon(Icons.arrow_back, color: Colors.white, size: 40,)) : Text(''),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: demandasListAsync.when(
                    data: (requerentes) {
                      if (requerentes.isEmpty) {
                        return const Text(
                          'Você não possui documents associados à requerentes!',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Column(
                        children: requerentes.asMap().entries.map((entry) {
                          return DemandasViewButton(
                            demanda: entry.value,
                            ref: ref,
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: LoadingCircle(),
                    ),
                    error: (error, stack) => Text(
                      'Error: $error',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              )
            ]
          )
        )
      )
    );
  }
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