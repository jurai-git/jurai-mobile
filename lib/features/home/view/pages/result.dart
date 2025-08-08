import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/probability.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';
import 'package:jurai/features/home/view/widgets/topic_information.dart';
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
      _ChartData("Perda", double.parse((widget.probability.negativePercentage*100).toStringAsFixed(1))),
      _ChartData("Parcial", double.parse((widget.probability.partialPercentage*100).toStringAsFixed(1))),
      _ChartData("Ganho", double.parse((widget.probability.positivePercentage*100).toStringAsFixed(1)))
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
              title: ChartTitle(text: "Resultados (em %)", textStyle: TextStyle(color: Colors.white)),
              legend: Legend(isVisible: true, isResponsive: true, position: LegendPosition.bottom, orientation: LegendItemOrientation.horizontal, textStyle: TextStyle(color: Colors.white  )),
              tooltipBehavior: _tooltip,
              series: <CircularSeries<_ChartData, String>>[
                DoughnutSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: "Probabilidade",
                  radius: "100%",
                  innerRadius: "60%",
                  dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(color: Colors.white)),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TopicInformation(topicName: "Ementa", topicData: widget.probability.input, topicImage: "img/assuntoPrincipal.svg", maxLines: null, kbType: TextInputType.multiline,),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CustomBotNavBar(customIndex: 3,)));
                },
                child: Text("Fazer outra análise", style: TextStyle(color: Color(0xFF387FB9)),) 
              ),
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