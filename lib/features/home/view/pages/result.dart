import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/probability.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Result extends ConsumerStatefulWidget {
  final Probability probability;


  const Result({super.key, required this.probability});

  @override
  ConsumerState<Result> createState() => _ResultState();
}

class _ResultState extends ConsumerState<Result> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState(){
    data = [
      _ChartData("Perda", widget.probability.negativePercentage),
      _ChartData("Neutro", widget.probability.partialPercentage),
      _ChartData("Ganho", widget.probability.positivePercentage)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
      appBar: AppBar(title: Text(
          "Análise de Probabilidade",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF387FB9)),   
        centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCircularChart(
              palette: [
                Colors.red,
                Colors.yellow,
                Colors.green
              ],
              tooltipBehavior: _tooltip,
              series: <CircularSeries<_ChartData, String>>[
                DoughnutSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: "Probabilidade"
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ChartData{
  final String x;
  final double y;

  _ChartData(this.x, this.y);
}