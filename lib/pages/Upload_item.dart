import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sortify/services/database.dart';
import 'package:sortify/services/shared_pref.dart';
import 'package:sortify/services/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadItem extends StatefulWidget {
  String category, id;
  UploadItem({required this.category, required this.id});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController quantitycontroller = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? id, name;

  getthesharedpref() async {
    id = await SharedpreferenceHelper().getUserId();
    name = await SharedpreferenceHelper().getUserName();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref();
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 30.0,
                              ),
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
                          selectedImage != null
                              ? Center(
                                  child: Container(
                                      height: 180,
                                      width: 180,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(selectedImage!,
                                            fit: BoxFit.cover),
                                      )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black54,
                                              width: 4.0),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Pickup Location",
                                style: AppWidget.normaltextstyle(20.0)),
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
                                      controller: addresscontroller,
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
                                style: AppWidget.normaltextstyle(20.0)),
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
                                      controller: quantitycontroller,
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
                          GestureDetector(
                            onTap: () async {
                              if ( //selectedImage != null &&
                                  addresscontroller.text.isNotEmpty &&
                                      quantitycontroller.text.isNotEmpty) {
                                // Add a try-catch block to handle potential errors gracefully
                                try {
                                  String itemid = randomAlphaNumeric(10);
                                  // Reference firebaseStorageRef = FirebaseStorage
                                  //     .instance
                                  //     .ref()
                                  //     .child("blogimage")
                                  //     .child(itemid);

                                  // // Start the upload task
                                  // final UploadTask task = firebaseStorageRef
                                  //     .putFile(selectedImage!);

                                  // // Await for the upload to complete
                                  // var snapshot = await task;

                                  // // Get the download URL from the completed task
                                  // var downloadUrl =
                                  //     await snapshot.ref.getDownloadURL();

                                  Map<String, dynamic> addItem = {
                                    "Image": "",
                                    "Address": addresscontroller.text,
                                    "Quantity": quantitycontroller.text,
                                    "UserId": id,
                                    "Name": name,
                                    "Status": "Pending",
                                  };

                                  await DatabaseMethod()
                                      .addUserUploadItem(addItem, id!, itemid);
                                  await DatabaseMethod()
                                      .addadminItem(addItem, itemid);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Uploaded Successfully",
                                        style: AppWidget.whitetextstyle(22.0)),
                                  ));

                                  // Clear the fields and image after successful upload
                                  setState(() {
                                    addresscontroller.text = "";
                                    quantitycontroller.text = "";
                                    selectedImage = null;
                                  });
                                } catch (e) {
                                  // If anything goes wrong, show an error message
                                  print("Failed to upload. Error: $e");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text(
                                        "Upload Failed. Please try again."),
                                  ));
                                }
                              }
                            },
                            child: Center(
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(25.0),
                                child: Container(
                                  height: 60.0,
                                  width:
                                      MediaQuery.of(context).size.width / 2.0,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Center(
                                    child: Text(
                                      "UPLOAD",
                                      style: AppWidget.whitetextstyle(25.0),
                                    ),
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
