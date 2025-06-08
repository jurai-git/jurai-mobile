import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/view/widgets/demandas_view_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DemandasInformation extends ConsumerStatefulWidget {
  const DemandasInformation({super.key});

  @override
  ConsumerState<DemandasInformation> createState() => _DemandasInformationState();
}

class _DemandasInformationState extends ConsumerState<DemandasInformation> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final demandasListAsync = ref.watch(demandaListProvider);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 24, 29, 1),
      appBar: AppBar(
        title: const Text(
          "Lista de Demandas",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF387FB9)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: demandasListAsync.when(
                data: (demandas) {
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    if(isLoading){
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                  if (demandas.isEmpty) {
                    return const Text(
                      'O requerente selecionado não possui demandas!',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  return Column(
                    children: demandas.asMap().entries.map((entry) {
                      return DemandasViewButton(
                        demanda: entry.value,
                        ref: ref,
                      );
                    }).toList(),
                  );
                },
                loading: (){
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
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return DemandasViewButton(demanda: Demanda.f(), ref: ref);
                      },
                    ),
                  );
                },
                error: (error, stack) => Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}