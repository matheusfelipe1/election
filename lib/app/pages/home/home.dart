import 'package:election/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = new TextEditingController();
  HomeController controller = Modular.get<HomeController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.dataCandidates.clear();
    controller.getDataInRealtime();
    controller.organizerData();
    print(controller.dataCandidates);
    controller.getAllCandidates();
    controller.func = updateState;
    super.initState();
  }

  filterCandidates(String query) {
    if (query == null || query == '') {
      setState(() {
        controller.dataCandidates = controller.data;
      });
    }
    if (mounted)
      setState(() {
        controller.dataCandidates = controller.data
            .where((element) => element
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()))
            .toList();
      });
  }

  updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.organizerData();
          setState(() {});
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.70,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(35)),
                    child: TextFormField(
                      controller: search,
                      onChanged: (query) => filterCandidates(query),
                      decoration: InputDecoration(
                          hintText: 'Pesquisar',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[700],
                          )),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  color: Colors.blueAccent,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: prefer_const_constructors
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 13, top: 5, bottom: 5),
                        child: Text(
                          'Candidatos',
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 13, top: 5, bottom: 5),
                        child: Text(
                          'Quantidade de votos',
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Material(
                child: Container(
                  width: size.width,
                  height: size.height * 0.6,
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
                                backgroundColor: Colors.white,
                                child: controller.dataCandidates[i]['foto'] !=
                                        ''
                                    ? Container(
                                        width: size.width * 0.13,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .dataCandidates[i]['foto']),
                                                fit: BoxFit.fill)),
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: size.height * 0.04,
                                      ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.dataCandidates[i]['name'],
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'Turma, ' +
                                        controller.dataCandidates[i]['turma'],
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
