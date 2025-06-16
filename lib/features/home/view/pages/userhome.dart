import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/chart_data_provider.dart';
import 'package:jurai/features/home/providers/recent_acess_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
import 'package:jurai/features/home/view/widgets/recent_access_requerente.dart';
import 'package:jurai/features/home/models/chart_data.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserHome extends ConsumerStatefulWidget {
  const UserHome({super.key});

  @override
  ConsumerState<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends ConsumerState<UserHome> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final asyncList = ref.watch(recentReqAcessListProvider);
    final asyncRequerentes = ref.watch(requerenteListProvider);
    final asyncChartData = ref.watch(chartDataProvider);
    final asyncDemandas = ref.watch(allDemandaListProvider);
    final currentAdvogado = ref.watch(advogadoProvider);

    // Trigger chart data fetch when requerentes are loaded
    ref.listen(requerenteListProvider, (previous, next) {
      if (next.hasValue) {
        ref.read(chartDataProvider.notifier).refresh();
      }
    });

    return Container(
      color: const Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Nav(advogado: ref.watch(advogadoProvider)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                    child: Row(
                      children: [
                        const Text(
                          "Olá, ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Text(
                          currentAdvogado?.username ?? "",
                          style: const TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        const Text(
                          "O que deseja fazer ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const Text(
                          "hoje?",
                          style: TextStyle(
                            color: Color(0xFF387FB9),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 35, bottom: 10),
                    child: Row(
                      children: [
                        const Text(
                          "Acessos ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        const Text(
                          "Recentes",
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
              SizedBox(
                height: 250,
                child: asyncList.when(
                  data: (list) {
                    if (list.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.close, size: 80, color: Colors.grey),
                            const SizedBox(height: 10),
                            Text("Você não selecionou nenhum requerente",
                                style: TextStyle(color: Colors.grey, fontSize: 18)),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, index) {
                        return RecentAccessRequerente(requerente: list[index]);
                      },
                    );
                  },
                  error: (error, stackTrace) => Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.grey),
                        const SizedBox(height: 10),
                        Text("Um erro inesperado ocorreu",
                            style: TextStyle(color: Colors.grey, fontSize: 18)),
                      ],
                    ),
                  ),
                  loading: () => null,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: asyncChartData.when(
                  data: (chartData) {
                    return chartData != null && chartData.isNotEmpty
                        ? SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                            primaryYAxis: NumericAxis(
                              labelStyle: const TextStyle(color: Colors.white),
                              minimum: 0,
                              maximum: chartData.map((d) => d.y).reduce((a, b) => a > b ? a : b) + 1,
                              interval: 1,
                            ),
                            tooltipBehavior: _tooltip,
                            title: const ChartTitle(
                                text: 'Demandas por Requerente',
                                textStyle: TextStyle(color: Colors.white)),
                            series: <CartesianSeries<ChartData, String>>[
                              ColumnSeries<ChartData, String>(
                                trackColor: Colors.white,
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: 'Demandas',
                                color: const Color.fromRGBO(8, 142, 255, 1),
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                  error: (error, stackTrace) => Text('Error: $error'),
                  loading: () => Skeletonizer(
                    enabled: true,
                    enableSwitchAnimation: true,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: const TextStyle(color: Colors.white),
                        minimum: 0,
                        maximum: 5,
                        interval: 1,
                      ),
                      tooltipBehavior: _tooltip,
                      title: const ChartTitle(
                          text: 'Demandas per Requerente',
                          textStyle: TextStyle(color: Colors.white)),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          trackColor: Colors.white,
                          dataSource: [
                            ChartData('Loading', 3),
                            ChartData('Loading', 2),
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          name: 'Demandas',
                          color: const Color.fromRGBO(8, 142, 255, 1),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}