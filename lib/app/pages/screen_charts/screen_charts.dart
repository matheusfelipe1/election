import 'package:election/app/pages/screen_charts/screen_charts_controller.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_modular/flutter_modular.dart';

class ScreenCharts extends StatefulWidget {
  const ScreenCharts({Key? key}) : super(key: key);

  @override
  State<ScreenCharts> createState() => _ScreenChartsState();
}

class _ScreenChartsState extends State<ScreenCharts> {
  ScreenChartsController controller = Modular.get<ScreenChartsController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.organizerData();
    int ctt = 0;
    for (var item in controller.dataCandidates) {
      controller.data.add(SubscriberSeries(
        year: item['name'].toString(),
        subscribers: item['qttVotes'],
        barColor: ctt == 0
            ? charts.ColorUtil.fromDartColor(Colors.blue)
            : ctt == 1
                ? charts.ColorUtil.fromDartColor(Colors.green)
                : ctt == 2
                    ? charts.ColorUtil.fromDartColor(Colors.yellow)
                    : charts.ColorUtil.fromDartColor(Colors.red),
      ));
      ctt++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SubscriberChart(
          data: controller.data,
        ),
      ),
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
  ScreenChartsController controller = Modular.get<ScreenChartsController>();

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
                      "Turma 26",
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
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: 17),
              color: Colors.grey,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Candidatos',
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.4,
            child: ListView.builder(
                itemCount: controller.dataCandidates.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        onTap: () {
                          Modular.to.pushNamed('/profile-details',
                              arguments: controller.dataCandidates[i]);
                        },
                        leading: CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: i == 0
                              ? Colors.blue
                              : i == 1
                                  ? Colors.green
                                  : i == 2
                                      ? Colors.yellow
                                      : Colors.red,
                          // child: Icon(
                          //   Icons.person,
                          //   color: Colors.black,
                          //   size: size.height * 0.04,
                          // ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.dataCandidates[i]['name'],
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black),
                            ),
                            Text(
                              controller.dataCandidates[i]['age'].toString() +
                                  ' anos',
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: Text(
                          controller.dataCandidates[i]['qttVotes']
                              .toString()
                              .split('.')
                              .first,
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.black),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
