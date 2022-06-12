import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/models/chat_model.dart';
import 'package:election/app/pages/message_chat/message_chat_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MessageChat extends StatefulWidget {
  dynamic data;
  MessageChat({Key? key, this.data}) : super(key: key);

  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  TextEditingController text = new TextEditingController();
  MessageChatController controller = Modular.get<MessageChatController>();
  AuthController _auth = Modular.get<AuthController>();
  ScrollController _scroll = new ScrollController();

  updatedState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.listenMessageInDatabase();
    controller.func = updatedState;
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
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Modular.to.pop(),
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey,
        title: Text(
          widget.data['name'],
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.82,
              width: size.width,
              child: controller.selectedChat!.messages!.length == 0
                  ? Container()
                  : ListView.builder(
                      controller: _scroll,
                      reverse: true,
                      itemCount: controller.selectedChat!.messages!.length,
                      itemBuilder: (context, i) {
                        if (controller.selectedChat!.messages![i].sender ==
                            _auth.user.userId) {
                          return myContext(
                              controller.selectedChat!.messages![i], context);
                        } else {
                          return anotherContext(
                              controller.selectedChat!.messages![i], context);
                        }
                      }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5,
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.7,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15),
                          child: TextFormField(
                            onFieldSubmitted: (query) async {
                              if (text.text != '') {
                                await controller.addMessage(
                                  query.trim(),
                                  'message',
                                );
                                text.text = '';
                                calculateScroll();
                              }
                            },
                            keyboardType: TextInputType.text,
                            controller: text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Digite sua mensage'),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            UtilsModalMessage().accessMessageModal(
                                title: 'Deseja enviar anexar uma imagem?',
                                func: () {
                                  controller.getImage(ImageSource.gallery);
                                },
                                func2: () {
                                  controller.getImage(ImageSource.camera);
                                },
                                colorButton: Colors.green,
                                context: context);
                          },
                          icon: Icon(Icons.image)),
                      IconButton(
                          onPressed: () async {
                            if (text.text != '') {
                              await controller.addMessage(
                                text.text.trim(),
                                'message',
                              );
                              text.text = '';
                              calculateScroll();
                            }
                          },
                          icon: Icon(
                            Icons.send,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  myContext(Message message, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: avoid_unnecessary_containers
    switch (message.type) {
      case 'message':
        return new Align(
          alignment: Alignment.centerRight,
          child: new Card(
            elevation: 10,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(message.value!),
            ),
          ),
        );
      case 'image':
        return GestureDetector(
          onTap: () {
            final map = {'foto': message.value!, 'name': widget.data['name']};
            Modular.to.pushNamed('/image-details', arguments: map);
          },
          child: new Align(
            alignment: Alignment.centerRight,
            child: new Card(
              elevation: 10,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: size.width * 0.5,
                    child: new Image.network(message.value!, frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return child;
                    }, loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
              ),
            ),
          ),
        );
        ;
      default:
    }
  }

  anotherContext(Message message, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (message.type) {
      case 'message':
        return new Align(
          alignment: Alignment.centerLeft,
          child: new Card(
            color: Colors.blue,
            elevation: 10,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                message.value!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      case 'image':
        return GestureDetector(
          onTap: () {
            final map = {'foto': message.value!, 'name': widget.data['name']};
            Modular.to.pushNamed('/image-details', arguments: map);
          },
          child: new Align(
            alignment: Alignment.centerLeft,
            child: new Card(
              color: Colors.blue,
              elevation: 10,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width * 0.5,
                  child: new Image.network(message.value!, frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  }, loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.grey),
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
        );
      default:
    }
  }

  calculateScroll() {
    Future.delayed(Duration(microseconds: 500), () {
      _scroll.animateTo(_scroll.position.minScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }
}
