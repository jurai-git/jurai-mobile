import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/requerente.dart';

class RequerenteNotifier extends StateNotifier<Requerente?>{
  RequerenteNotifier() : super(null);

  void setRequerente(Requerente requerente){
    state = requerente;
  }

  void clear(){
    state = null;
  }
}

class RequerenteListNotifier extends StateNotifier<List<Requerente>>{
  RequerenteListNotifier() : super([]);

  void setRequerenteList(List<Requerente> requerenteList){
    state = requerenteList;
  }

  void clear(){
    state = [];
  }

}

final requerenteProvider = StateNotifierProvider<RequerenteNotifier, Requerente?>((ref) {
  return RequerenteNotifier();
});

final requerenteListProvider = StateNotifierProvider<RequerenteListNotifier, List<Requerente>>((ref) {
  return RequerenteListNotifier();
});