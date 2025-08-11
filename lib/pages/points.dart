import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sortify/services/database.dart';
import 'package:sortify/services/shared_pref.dart';
import 'package:sortify/services/widget_support.dart';

class Points extends StatefulWidget {
  const Points({super.key});

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {
  String? id, mypoints;
  TextEditingController pointscontroller = TextEditingController();
  TextEditingController upicontroller = TextEditingController();

  Future<void> getthesharedpref() async {
    id = await SharedpreferenceHelper().getUserId();
    setState(() {});
  }

  Future<void> ontheload() async {
    await getthesharedpref();
    if (id != null) {
      mypoints = await getUserPoints(id!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  Future<String> getUserPoints(String docId) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(docId).get();
      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        var points = data['Points'];
        return points.toString();
      } else {
        return 'No document';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error';
    }
  }

  Future<void> openBox() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  "Redeem Points",
                  style: AppWidget.healinetextstyle(24.0),
                ),
              ),
              SizedBox(height: 20.0),
              Text("Points to Redeem", style: AppWidget.lighttextstyle(18.0)),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: pointscontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter points",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text("Enter UPI ID", style: AppWidget.lighttextstyle(18.0)),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: upicontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter UPI ID",
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () async {
                  if (pointscontroller.text.isNotEmpty &&
                      upicontroller.text.isNotEmpty &&
                      mypoints != null &&
                      int.tryParse(mypoints!) != null &&
                      int.tryParse(pointscontroller.text) != null &&
                      int.parse(mypoints!) >=
                          int.parse(pointscontroller.text)) {
                    int updatedpoints =
                        int.parse(mypoints!) - int.parse(pointscontroller.text);
                    await DatabaseMethod()
                        .updateUserPoints(id!, updatedpoints.toString());
                    Navigator.pop(context);
                    setState(() {
                      mypoints = updatedpoints.toString();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Invalid input or insufficient points"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Center(
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Redeem Now",
                        style: AppWidget.whitetextstyle(18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mypoints == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 70.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.black,
                              size: 28.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Rewards Corner",
                            style: AppWidget.healinetextstyle(30.0),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Points",
                                  style: AppWidget.whitetextstyle(18.0)
                                      .copyWith(color: Colors.white70),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  mypoints ?? "0",
                                  style: AppWidget.whitetextstyle(36.0),
                                ),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              'images/coin.png',
                              height: 80,
                              width: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        openBox();
                      },
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          width: MediaQuery.of(context).size.width / 1.8,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Redeem Points",
                              style: AppWidget.whitetextstyle(22.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
