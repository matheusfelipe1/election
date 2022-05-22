import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageDetails extends StatefulWidget {
  dynamic data;
  ImageDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  TransformationController controller = new TransformationController();
  var initialControllerValue;

  @override
  void initState() {
    // TODO: implement initState
    initialControllerValue = controller.value;
    super.initState();
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
          'Perfil de ' + widget.data['name'],
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: Center(
          child: Container(
        width: size.width,
        height: size.height * 0.7,
        child: InteractiveViewer(
          panEnabled: false, // Set it to false
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 5,
          // onInteractionStart: (details) {
          //   initialControllerValue = controller.value;
          // },
          transformationController: controller,
          onInteractionEnd: (details) {
            controller.value = initialControllerValue;
          },
          child: Image.network(
            widget.data['foto'],
            fit: BoxFit.fill,
          ),
        ),
      )),
    );
  }
}
