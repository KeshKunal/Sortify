import 'package:flutter/material.dart';
import 'package:sortify/services/widget_support.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({super.key});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 30.0,
                            )),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 5.5),
                      Text(
                        "Upload Items",
                        style: AppWidget.healinetextstyle(25.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: Color.fromARGB(255, 229, 252, 199)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black54, width: 4.0),
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
