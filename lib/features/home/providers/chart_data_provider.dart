import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/viewmodel/home_viewmodel.dart';
import 'package:jurai/features/home/models/chart_data.dart';

final chartDataProvider = StateNotifierProvider<ChartDataNotifier, AsyncValue<List<ChartData>?>>((ref) {
  return ChartDataNotifier(ref);
});

class ChartDataNotifier extends StateNotifier<AsyncValue<List<ChartData>?>> {
  final Ref ref;

  ChartDataNotifier(this.ref) : super(const AsyncValue.loading()) { // Start with loading state
    _initialize();
  }

  Future<void> _initialize() async {
    final asyncRequerentes = ref.watch(requerenteListProvider);
    if (asyncRequerentes.hasValue) {
      await _fetchChartData();
    }
  }

  Future<void> _fetchChartData() async {
    state = const AsyncValue.loading(); // Ensure loading state during fetch
    try {
      final requerenteList = ref.read(requerenteListProvider).valueOrNull ?? [];
      if (requerenteList.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }
      Map<int, int> requerenteDemandCount = {};
      for (var requerente in requerenteList) {
        await ref.read(homeViewModelProvider.notifier).getAllDemandasFromRequerente(id_requerente: requerente.id_requerente);
        final currentDemandas = ref.read(demandaListProvider).valueOrNull ?? [];
        requerenteDemandCount[requerente.id_requerente] = currentDemandas.length;
      }
      final data = requerenteList.map((requerente) {
        final count = requerenteDemandCount[requerente.id_requerente] ?? 0;
        return ChartData(requerente.nome ?? 'Unknown', count);
      }).toList();
      print('Chart data assigned: $data');
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void refresh() => _fetchChartData();
}