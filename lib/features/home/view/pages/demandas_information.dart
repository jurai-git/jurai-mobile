import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final demandaListAsync = ref.read(demandaListProvider);
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
                padding: EdgeInsets.symmetric(horizontal: 25),
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                    return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Icon(Icons.close, color: Colors.grey, size: 80,),
                              const SizedBox(height: 10),
                              Text(
                                'O requerente selecionado não possui demandas!',
                                style: TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
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
                      itemCount: (MediaQuery.of(context).size.height/120).toInt(),
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