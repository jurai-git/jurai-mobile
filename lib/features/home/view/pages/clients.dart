import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
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

class _ClientsState extends ConsumerState<Clients> {
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  List<Requerente> _filteredRequerentes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRequerentes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRequerentes);
    _searchController.dispose();
    super.dispose();
  }

  void _filterRequerentes() {
    final query = _searchController.text.toLowerCase();
    final requerenteListAsync = ref.read(requerenteListProvider);
    requerenteListAsync.whenData((requerentes) {
      setState(() {
        _filteredRequerentes = requerentes
            .where((requerente) =>
                requerente.nome.toLowerCase().contains(query))
            .toList();
      });
    });
  }

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
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar por nome...',
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
                child: requerenteListAsync.when(
                  data: (requerentes) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (isLoading) {
                        setState(() {
                          isLoading = false;
                          if (_filteredRequerentes.isEmpty &&
                              _searchController.text.isEmpty) {
                            _filteredRequerentes = requerentes;
                          }
                        });
                      }
                    });
                    if (requerentes.isEmpty) {
                      return  Text(
                        'Você não possui requerentes associados!',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    final displayList = _searchController.text.isNotEmpty
                        ? _filteredRequerentes
                        : requerentes;
                    return Column(
                      children: displayList.asMap().entries.map((entry) {
                        return RequerentesViewButton(
                          requerente: entry.value,
                          ref: ref,
                        );
                      }).toList(),
                    );
                  },
                  loading: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!isLoading) {
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
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (MediaQuery.of(context).size.height / 200).toInt(),
                        itemBuilder: (context, index) {
                          return RequerentesViewButton(
                            requerente: Requerente.f(),
                            ref: ref,
                          );
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