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

class RequerenteListNotifier extends StateNotifier<AsyncValue<List<Requerente>>>{
  RequerenteListNotifier() : super(const AsyncValue.data([]));

  void setLoading() {
    state = const AsyncValue.loading();
  }

  void setRequerenteList(List<Requerente> requerenteList){
    state = AsyncValue.data(requerenteList);
  }

  void setError(Object error, StackTrace stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }

  void clear() {
    state = const AsyncValue.data([]);
  }

}

final requerenteProvider = StateNotifierProvider<RequerenteNotifier, Requerente?>((ref) {
  return RequerenteNotifier();
});

final requerenteListProvider = StateNotifierProvider<RequerenteListNotifier, AsyncValue<List<Requerente>>>((ref) {
  return RequerenteListNotifier();
});