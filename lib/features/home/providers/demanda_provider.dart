import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/demanda.dart';

class DemandaNotifier extends StateNotifier<Demanda?> {
  DemandaNotifier() : super(null);

  void setDemanda(Demanda demanda) {
    state = demanda;
  }

  void clear() {
    state = null;
  }
}

class DemandaListNotifier extends StateNotifier<AsyncValue<List<Demanda>>> {
  DemandaListNotifier() : super(const AsyncValue.data([]));

  void setLoading() {
    state = const AsyncValue.loading();
  }

  void setDemandaList(List<Demanda> demandaList) {
    state = AsyncValue.data(demandaList);
  }

  void setError(Object error, StackTrace stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

final demandaProvider = StateNotifierProvider<DemandaNotifier, Demanda?>((ref) {
  return DemandaNotifier();
});

final demandaListProvider = StateNotifierProvider<DemandaListNotifier, AsyncValue<List<Demanda>>>((ref) {
  return DemandaListNotifier();
});