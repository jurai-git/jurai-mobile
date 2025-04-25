import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/demanda.dart';

class DemandaNotifier extends StateNotifier<Demanda?>{
  DemandaNotifier() : super(null);

  void setDemanda(Demanda demanda){
    state = demanda;
  }

  void clear(){
    state = null;
  }
}

class DemandaListNotifier extends StateNotifier<List<Demanda>>{
  DemandaListNotifier() : super([]);

  void setDemandaList(List<Demanda> demandaList){
    state = demandaList;
  }

  void clear(){
    state = [];
  }

}

final demandaProvider = StateNotifierProvider<DemandaNotifier, Demanda?>((ref) {
  return DemandaNotifier();
});

final demandaListProvider = StateNotifierProvider<DemandaListNotifier, List<Demanda>>((ref) {
  return DemandaListNotifier();
});