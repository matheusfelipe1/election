import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/message_chat/message_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListMessageChat extends StatefulWidget {
  ListMessageChat({Key? key}) : super(key: key);

  @override
  State<ListMessageChat> createState() => _ListMessageChatState();
}

class _ListMessageChatState extends State<ListMessageChat> {
  MessageChatController controller = Modular.get<MessageChatController>();
  AuthController _auth = Modular.get<AuthController>();

  int? param;

  updatedState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.funcList = updatedState;
    _init();
    controller.getMessageInDatabase();
  }

  _init() {
    if (_auth.user.admin) {
      if (mounted)
        setState(() {
          param = 1;
        });
    } else {
      if (mounted)
        setState(() {
          param = 0;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
        ),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => Modular.to.pop(),
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey,
        title: Text(
          'Lista de mensagem',
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: controller.chats!.length,
          itemBuilder: (context, i) {
            return Container(
                child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: ListTile(
                        onTap: () {
                          final map = {
                            'name': controller.chats![i].profileModel!.name!
                          };
                          controller.selectedChat = controller.chats![i];
                          controller.idChat = controller.chats![i].id!;
                          Modular.to.pushNamed('/details-chat', arguments: map);
                        },
                        leading: controller.chats![i].profileModel!.foto != ''
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: NetworkImage(controller
                                              .chats![i].profileModel!.foto!),
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
                        title: Text(
                          controller.chats![i].profileModel!.name!,
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.black),
                        ),
                        subtitle: Text(
                          controller.chats![i].messages!.first.sender! ==
                                  _auth.user.userId
                              ? controller.chats![i].messages!.first.type! ==
                                      'image'
                                  ? 'Você: imagem'
                                  : 'Você: ' +
                                      controller
                                          .chats![i].messages!.first.value!
                              : controller.chats![i].messages!.first.type! ==
                                      'image'
                                  ? '${controller.chats![i].profileModel!.name!}: imagem'
                                  : '${controller.chats![i].profileModel!.name!}: ' +
                                      controller
                                          .chats![i].messages!.first.value!,
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.black),
                        ),
                      ),
                    )));
          }),
    );
  }
}
