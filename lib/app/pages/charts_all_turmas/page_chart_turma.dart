import 'dart:async';

import 'package:election/app/pages/charts_all_turmas/page_chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_modular/flutter_modular.dart';

class PageChartTurmas extends StatefulWidget {
  const PageChartTurmas({Key? key}) : super(key: key);

  @override
  State<PageChartTurmas> createState() => _PageChartTurmasState();
}

class _PageChartTurmasState extends State<PageChartTurmas> {
  PageChartController controller = Modular.get<PageChartController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.renderChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SubscriberChart(
      data: controller.data,
    );
  }
}

class SubscriberSeries {
  final String year;
  final double subscribers;
  final charts.Color barColor;

  SubscriberSeries(
      {required this.year, required this.subscribers, required this.barColor});
}

class SubscriberChart extends StatefulWidget {
  final List<SubscriberSeries> data;

  SubscriberChart({required this.data});

  @override
  State<SubscriberChart> createState() => _SubscriberChartState();
}

class _SubscriberChartState extends State<SubscriberChart> {
  PageChartController controller = Modular.get<PageChartController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.organizerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: widget.data,
          domainFn: (SubscriberSeries series, _) => series.year,
          measureFn: (SubscriberSeries series, _) => series.subscribers,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Turma " + controller.turmaText.toString(),
                      style: const TextStyle(
                          fontFamily: 'Poppins', color: Colors.black),
                      // style: Theme.of(context).textTheme.body2,
                    ),
                    Expanded(
                      child: charts.BarChart(series, animate: true),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
