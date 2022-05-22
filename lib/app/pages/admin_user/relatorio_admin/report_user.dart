import 'package:election/app/pages/admin_user/relatorio_admin/report_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReportUser extends StatefulWidget {
  const ReportUser({Key? key}) : super(key: key);

  @override
  State<ReportUser> createState() => _ReportUserState();
}

class _ReportUserState extends State<ReportUser> {
  ReportUserController controller = Modular.get<ReportUserController>();
  String dropdownValue = 'Selecione uma turma';
  updateState() {
    if (mounted) setState(() {});
  }

  List<String> turmas = [
    'Selecione uma turma',
    'Turma 26',
    'Turma 36',
    'Turma 25',
    'Turma 19',
    'Turma 15',
    'Turma 10',
  ];
  @override
  void initState() {
    // TODO: implement initState
    controller.func = updateState;
    controller.dataCandidates.clear();
    controller.getDataInRealtime();
    controller.getAllCandidates();
    controller.organizerData();
    controller.data.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            // controller.data.clear();
            setState(() {});
          },
          child: Container(
            width: size.width,
            child: Column(
              children: [
                Container(
                  child: Container(
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
                        hint: Text('Selecione uma turma',
                            style: const TextStyle(
                                fontFamily: 'Poppins', color: Colors.black)),
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
                            print(dropdownValue);
                            controller.filterDatas(dropdownValue);
                          });
                        },
                        items: turmas
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                controller.data.length == 0
                    ? Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Center(
                          child: Text('Não possui candidatos nessa turma',
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black)),
                        ),
                      )
                    : Container(
                        height: size.height * 0.6,
                        child: ListView.builder(
                            itemCount: controller.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                  child: Card(
                                      elevation: 4,
                                      child: ListTile(
                                        onTap: () {
                                          Modular.to.pushNamed(
                                              '/profile-details',
                                              arguments: controller.data[i]);
                                        },
                                        leading: controller.data[i]['foto'] !=
                                                ''
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: size.width * 0.12,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              controller.data[i]
                                                                  ['foto']),
                                                          fit: BoxFit.fill)),
                                                ),
                                              )
                                            : CircleAvatar(
                                                maxRadius: 25,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                  size: size.height * 0.04,
                                                ),
                                              ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.data[i]['name'],
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              controller.data[i]['age']
                                                      .toString() +
                                                  ' anos',
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        trailing: Text(controller.data[i]
                                                ['qttVotes']
                                            .toString()
                                            .split('.')
                                            .first),
                                      )));
                            }),
                      )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.createFileXlsx(updateState);
          },
          child: Icon(FontAwesomeIcons.filePdf)),
    );
  }
}
