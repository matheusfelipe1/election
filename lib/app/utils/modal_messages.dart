import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilsModalMessage {
  generalToast({required String title}) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showMessageModal({
    required String title,
    required VoidCallback func,
    required Color colorButton,
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
              // backgroundColor: Colors.grey[400],
              title: Text(
                title,
                style: TextStyle(
                    // color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 15),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Modular.to.pop(),
                          child: Container(
                            width: size.width * 0.28,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(35)),
                            child: Text(
                              'Cancelar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12),
                            ),
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          onTap: () => func.call(),
                          child: Container(
                            width: size.width * 0.28,
                            decoration: BoxDecoration(
                                color: colorButton,
                                borderRadius: BorderRadius.circular(35)),
                            child: Text(
                              'Sim',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12),
                            ),
                          )),
                    ],
                  ),
                ),
              ));
        });
  }

  accessMessageModal({
    required String title,
    required VoidCallback func,
    required VoidCallback func2,
    required Color colorButton,
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
              // backgroundColor: Colors.grey[400],
              title: Text(
                title,
                style: TextStyle(
                    // color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 15),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => func.call(),
                          child: Container(
                            width: size.width * 0.28,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: size.width * 0.028),
                                  Text(
                                    'Galeria',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          onTap: () => func2.call(),
                          child: Container(
                            width: size.width * 0.28,
                            decoration: BoxDecoration(
                                color: colorButton,
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: size.width * 0.028),
                                  Text(
                                    'Camera',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ));
        });
  }

  loading(int param) {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: new Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             new CircularProgressIndicator(),
    //             SizedBox(
    //               width: 25,
    //             ),
    //             new Text("Aguarde.."),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
    switch (param) {
      case 1:
        EasyLoading.show(maskType: EasyLoadingMaskType.custom);
        break;
      default:
        EasyLoading.dismiss();
    }
  }
}
