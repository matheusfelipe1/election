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
    controller.organizerData();
    print(controller.dataCandidates);
    super.initState();
  }

  filterCandidates(String query) {
    if (query == null || query == '')
      controller.data = controller.dataCandidates;
    if (mounted)
      setState(() {
        controller.data = controller.dataCandidates
            .where((element) => element
                .toString()
                .toLowerCase()
                .contains(query.toString().toLowerCase()))
            .toList();
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
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
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: 17),
              color: Colors.blueAccent,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Candidatos',
                      style: const TextStyle(
                          fontFamily: 'Poppins', color: Colors.white),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Votos(%)',
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
                  itemCount: controller.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          leading: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: size.height * 0.04,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.data[i]['name'],
                                style: const TextStyle(
                                    fontFamily: 'Poppins', color: Colors.black),
                              ),
                              Text(
                                'Turma, ' + controller.data[i]['turma'],
                                style: const TextStyle(
                                    fontFamily: 'Poppins', color: Colors.black),
                              ),
                            ],
                          ),
                          trailing: Text(
                            controller.data[i]['qttVotes'].toString() + ' %',
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
    );
  }
}
