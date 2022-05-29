import 'package:election/app/pages/charts_all_turmas/page_chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../page_chart_turma.dart';

class SwitchCharts extends StatefulWidget {
  const SwitchCharts({Key? key}) : super(key: key);

  @override
  State<SwitchCharts> createState() => _SwitchChartsState();
}

class _SwitchChartsState extends State<SwitchCharts> {
  String dropdownValue = 'Selecione uma turma';
  PageChartController controller = Modular.get<PageChartController>();
  bool showCharts = false;

  @override
  void initState() {
    // TODO: implement initState
    controller.turmas.clear();
    controller.turmas.add('Selecione uma turma');
    controller.organizerData();
    controller.getTeams();
    controller.getDataInRealtime();
    controller.dataCandidates.clear();
    controller.func = updateState;
    controller.getAllCandidates();
    controller.listenValues();
    super.initState();
  }

  updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        controller.organizerData();
      },
      child: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 15),
                  height: size.height * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      // icon: const Icon(Icons.arrow_downward),
                      hint: Text('Selecione uma turma'),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      elevation: 16,
                      style: TextStyle(
                          color: dropdownValue == 'Selecione uma turma'
                              ? Colors.grey
                              : Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          controller.filter(newValue);
                          if (newValue == 'Selecione uma turma')
                            showCharts = false;
                        });
                      },
                      items: controller.turmas
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: dropdownValue == 'Selecione uma turma'
                      ? null
                      : () {
                          // Modular.to.pushNamed('/login');
                          setState(() {
                            showCharts = true;
                          });
                          controller.turmaText =
                              dropdownValue.toString().split(' ').last;
                          controller.data.clear();
                          controller.renderChart();
                        },
                  child: Container(
                      width: size.width * 0.45,
                      margin: EdgeInsets.only(top: size.height * 0.12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: dropdownValue == 'Selecione uma turma'
                                ? Colors.grey
                                : Colors.green[700],
                            borderRadius: BorderRadius.circular(35)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text('Buscar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: size.height * 0.025)),
                          ),
                        ),
                      )
                      // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                      ),
                ),
                showCharts ? PageChartTurmas() : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
