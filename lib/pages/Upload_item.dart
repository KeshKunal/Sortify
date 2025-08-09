import 'package:flutter/material.dart';
import 'package:sortify/services/widget_support.dart';

class UploadItem extends StatefulWidget {
  String category, id;
  UploadItem({required this.category, required this.id});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            margin: EdgeInsets.only(top: 30.0),
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
                        color: Color.fromARGB(230, 191, 220, 236)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black54, width: 4.0),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 30.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Pickup Location",
                                style: AppWidget.normaltextstyle(18.0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.location_on,
                                              color: Colors.green),
                                          hintText: "Enter Address",
                                          hintStyle:
                                              AppWidget.lighttextstyle(15.0)))),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Quantity",
                                style: AppWidget.normaltextstyle(18.0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.inventory,
                                              color: Colors.green),
                                          hintText: "Enter Quantity",
                                          hintStyle:
                                              AppWidget.lighttextstyle(15.0)))),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                height: 60.0,
                                width: MediaQuery.of(context).size.width / 2.0,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Text(
                                    "Upload",
                                    style: AppWidget.whitetextstyle(20.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
