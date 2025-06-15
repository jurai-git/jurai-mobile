import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/demandas_view_button.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Documents extends ConsumerStatefulWidget {
  const Documents({super.key});

  @override
  ConsumerState<Documents> createState() => _DocumentsState();
}

var currentDemanda;
int buttonIndex = 0;

class _DocumentsState extends ConsumerState<Documents>{ 
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  List<Demanda> _filteredDemandas = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterDemandas);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterDemandas);
    _searchController.dispose();
    super.dispose();
  }

  void _filterDemandas() {
    final query = _searchController.text.toLowerCase();
    final demandaListAsync = ref.read(allDemandaListProvider);
    demandaListAsync.whenData((demandas) {
      setState(() {
        _filteredDemandas = demandas
            .where((demanda) =>
                demanda.identificacao.toLowerCase().contains(query))
            .toList();
      });
    });
  }

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
              Nav(advogado: ref.watch(advogadoProvider),),
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
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar por identificação...',
                    hintStyle: TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.search, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty ? IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                      icon: Icon(Icons.close, color: Colors.white54,))
                      : null,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: demandasListAsync.when(
                    data: (demandas) {
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        if(isLoading){
                          setState(() {
                            isLoading = false;
                            if (_filteredDemandas.isEmpty &&
                              _searchController.text.isEmpty) {
                            _filteredDemandas = demandas;
                          }
                          });
                        }
                      });
                      if (demandas.isEmpty) {
                        return const Text(
                          'Você não possui documentos associados à requerentes!',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      final displayList = _searchController.text.isNotEmpty
                        ? _filteredDemandas
                        : demandas;
                      return Column(
                        children: displayList.asMap().entries.map((entry) {
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
                          itemCount: (MediaQuery.of(context).size.height/200).toInt(),
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
              )
            ]
          )
        )
      )
    );
  }
}