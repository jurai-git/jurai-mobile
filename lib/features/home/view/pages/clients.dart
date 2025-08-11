import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
import 'package:jurai/features/home/view/widgets/requerentes_view_button.dart';
import 'package:jurai/features/home/viewmodel/home_viewmodel.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  String? selectedDropdownValue = "A-Z";

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
        appBar: AppBar(
          title: Text("Lista de Requerentes", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF387FB9)),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                margin: EdgeInsets.fromLTRB(25,0,25,10),
                child: Row(
                  children: [
                    Container(
                       decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(177, 177, 177, 0.25)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(7.5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(30, 29, 34, 1),
                              border: BorderDirectional(end: BorderSide(color: Color.fromRGBO(177, 177, 177, 0.25), width: .7)),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                            child: Text('Ordenar', style: TextStyle(color: Color.fromRGBO(177, 177, 177, .8)),),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7.5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(30, 29, 34, 1),
                              border: BorderDirectional(start: BorderSide(color: Color.fromRGBO(177, 177, 177, 0.25), width: .7)),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(color: Color.fromRGBO(40, 39, 44, 1),)),
                                items: <String>['A-Z', 'Z-A'].map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: TextStyle(color: Colors.white, fontSize: 15),),
                                )).toList(),
                                value: selectedDropdownValue,
                                onChanged: (String? value){
                                  setState(() {
                                    selectedDropdownValue = value!;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 35,
                                  width: 60,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              )
                            )
                          ),
                        ]
                      ),
                    ),
                    Spacer(),
                    Text("placeholder", style: TextStyle(color: Colors.white54,),)
                  ],
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
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Icon(Icons.sentiment_dissatisfied_outlined, color: Colors.grey, size: 80,),
                            const SizedBox(height: 10),
                            Text(
                              'Você não possui requerentes associados!',
                              style: TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF387FB9),
                                  fixedSize: Size(125, 20)
                                ),
                                onPressed: (){
                                  setState(() {
                                    ref.watch(homeViewModelProvider.notifier).getAllRequerentes();
                                  });
                                }, 
                                child: Row(
                                  children: [
                                    Icon(Icons.refresh, color: Colors.white, size: 20,),
                                    Spacer(),
                                    Text("Recarregar", style: TextStyle(color: Colors.white),)
                                  ],
                                )
                              )
                            )
                          ],
                        ),
                      );
                    }
                    var displayList = _searchController.text.isNotEmpty
                        ? _filteredRequerentes
                        : requerentes;
                    if(selectedDropdownValue == "A-Z"){
                      setState(() {
                        
                      });
                      displayList.sort((a, b) => a.nome.compareTo(b.nome));
                      requerentes.sort((a, b) => a.nome.compareTo(b.nome));
                    }
                    else if(selectedDropdownValue == "Z-A"){
                      setState(() {
                        
                      });
                      displayList.sort((a, b) => a.nome.compareTo(b.nome));
                      displayList = displayList.reversed.toList();
                    }
                    return Column(
                      children: [
                        ...displayList.asMap().entries.map((entry) {
                        return RequerentesViewButton(
                          requerente: entry.value,
                          ref: ref,
                        );
                      }).toList(),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF387FB9),
                            fixedSize: Size(125, 20)
                          ),
                          onPressed: (){
                            setState(() {
                              ref.watch(homeViewModelProvider.notifier).getAllRequerentes();
                            });
                          }, 
                          child: Row(
                            children: [
                              Icon(Icons.refresh, color: Colors.white, size: 20,),
                              Spacer(),
                              Text("Recarregar", style: TextStyle(color: Colors.white),)
                            ],
                          )
                        )
                        ),
                      ]
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