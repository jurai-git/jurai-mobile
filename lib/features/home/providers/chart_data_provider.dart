import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/repositories/home_remote_repository.dart';
import 'package:jurai/features/home/models/chart_data.dart';

final chartDataProvider = StateNotifierProvider<ChartDataNotifier, AsyncValue<List<ChartData>?>>((ref) {
  return ChartDataNotifier(ref);
});

class ChartDataNotifier extends StateNotifier<AsyncValue<List<ChartData>?>> {
  final Ref ref;

  ChartDataNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final asyncRequerentes = ref.watch(requerenteListProvider);
    if (asyncRequerentes.hasValue) {
      await _fetchChartData();
    }
  }

  Future<void> _fetchChartData() async {
    state = const AsyncValue.loading();
    try {
      final requerenteList = ref.read(requerenteListProvider).valueOrNull ?? [];
      if (requerenteList.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      final repository = ref.read(homeRemoteRepositoryProvider);

      final List<ChartData> data = [];
      for (var requerente in requerenteList) {
        final res = await repository.getAllDemandasFromRequerente(id_requerente: requerente.id_requerente);
        final count = res.fold(
          (error) => 0,
          (demandas) => demandas.length,
        );
        data.add(ChartData(requerente.nome ?? 'Unknown', count));
      }

      print('Chart data assigned: $data');
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void refresh() => _fetchChartData();
}