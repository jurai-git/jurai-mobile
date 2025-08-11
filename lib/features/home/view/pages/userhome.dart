import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/chart_data_provider.dart';
import 'package:jurai/features/home/providers/recent_acess_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';
import 'package:jurai/features/home/view/widgets/nav.dart';
import 'package:jurai/features/home/view/widgets/quick_acess_button.dart';
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
    final asyncChartData = ref.watch(chartDataProvider);
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomBotNavBar(customIndex: 4,),
                          ),
                        );
                      }, 
                      style: IconButton.styleFrom(
                        shape: CircleBorder()
                      ),
                      icon: ClipOval(
                        child: Image.network(
                          "https://jurai-server.onrender.com/advogado/${currentAdvogado!.id.toString()}/pfp",
                          width: 60, 
                          height: 60, 
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Olá", style: TextStyle(color: Colors.white60, fontSize: 16),),
                        Text(currentAdvogado.username, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Spacer(),
                    Image.asset('img/jurailogo.png', width: 55,)
                  ],
                ),
              ),
              /*
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
              */
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Acessos ",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        const Text(
                          "Recentes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: asyncList.when(
                  data: (list) {
                    if (list.isEmpty) {
                      return Container(
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
                    return Row(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, index) {
                            return RecentAccessRequerente(requerente: list[index]);
                          },
                        ),
                      ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Demandas por ",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        const Text(
                          "Requerentes" ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
                                textStyle: TextStyle(color: Colors.white)),
                            series: <CartesianSeries<ChartData, String>>[
                              ColumnSeries<ChartData, String>(
                                borderRadius: BorderRadius.circular(10),
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
                  error: (error, stackTrace){
                    Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.grey),
                        const SizedBox(height: 10),
                        Text("Um erro inesperado ocorreu",
                            style: TextStyle(color: Colors.grey, fontSize: 18)),
                        ],
                      )
                    );
                  },
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
                          textStyle: TextStyle(color: Colors.white)),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                          borderRadius: BorderRadius.circular(10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 35, bottom: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Ações ",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        const Text(
                          "Rápidas" ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    QuickAcessButton(botNavBarIndex: 3, urlImage: "img/quick_search.png", primaryText: "Análise de Documentos", secondaryText: "Analise suas demandas rapidamente e receba os resultados da IA do JurAI"),
                    SizedBox(height: 10,),
                    QuickAcessButton(botNavBarIndex: 1, urlImage: "img/quick_client.png", primaryText: "Busca de Requerentes", secondaryText: "Filtre, busque e acesse as informações dos seus respectivos requerentes"),
                    SizedBox(height: 10,),
                    QuickAcessButton(botNavBarIndex: 4, urlImage: "img/quick_settings.png", primaryText: "Página de Configurações", secondaryText: "Acesse as informações da sua conta e configure o sistema do seu jeito"),
                    SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}