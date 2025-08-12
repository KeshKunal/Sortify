import 'package:flutter/material.dart';
import 'package:sortify/pages/Upload_item.dart';
import 'package:sortify/pages/points.dart';
import 'package:sortify/services/shared_pref.dart';
import 'package:sortify/services/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sortify/pages/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  String? id, mypoints, name;

  // ADD YOUR WORKING FUNCTION HERE
  Future<String> getUserPoints(String docId) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(docId).get();
      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        var points = data['Points'];
        return points.toString();
      } else {
        return "0";
      }
    } catch (e) {
      print('Error: $e');
      return "0";
    }
  }

  ontheload() async {
    id = await SharedpreferenceHelper().getUserId();
    name = await SharedpreferenceHelper().getUserName(); // Also fetch the name
    if (id != null) {
      mypoints = await getUserPoints(id!);
    }
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: mypoints == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Text("Hello, ",
                                style: AppWidget.blacktextstyle(25.0)),
                          ),
                          Text(
                            name! + "!",
                            style: AppWidget.greentextstyle(30.0),
                          ),
                          Spacer(),
                          // A profile icon
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 21.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.green.shade100,
                                child: Icon(
                                  Icons.person_outline,
                                  color: AppWidget.greentextstyle(35.0).color,
                                  size: 28,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      // Points Display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Points()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Color(0xFF4CAF50), // A vibrant green
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  )
                                ]),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Your Points",
                                        style: AppWidget.whitetextstyle(18.0)
                                            .copyWith(color: Colors.white70)),
                                    SizedBox(height: 5),
                                    Text(mypoints!,
                                        style: AppWidget.whitetextstyle(36.0)),
                                  ],
                                ),
                                Spacer(),
                                Image.asset(
                                  'images/coin.png',
                                  height: 80,
                                  width: 80,
                                ),
                                Icon(Icons.arrow_forward_ios_rounded,
                                    color: Colors.white, size: 30)
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0),

                      // -- CENTRAL ILLUSTRATION --
                      Center(
                        child: Transform.rotate(
                          angle: 0.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20, bottom: 15),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(183, 223, 219, 219),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withAlpha(25), // ~10% opacity
                                  blurRadius: 15,
                                  offset: Offset(4, 10),
                                )
                              ],
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(171, 207, 200, 200),
                                  width: 1),
                            ),
                            child: Image.asset(
                              "images/home1.png",
                              height: MediaQuery.of(context).size.height * 0.35,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Categories",
                          style: AppWidget.healinetextstyle(23.0),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        height: 130,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Add this check
                                  if (id != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UploadItem(
                                                category: "Plastic", id: id!)));
                                  } else {
                                    // Optional: Let the user know data is still loading
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please wait, loading user data...")),
                                    );
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFececf8),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: Colors.black45,
                                              width: 2.0)),
                                      child: Image.asset(
                                        "images/plastic.png",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      "Plastic",
                                      style: AppWidget.normaltextstyle(20.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFececf8),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.black45, width: 2.0)),
                                    child: Image.asset(
                                      "images/paper.png",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "Paper",
                                    style: AppWidget.normaltextstyle(20.0),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFececf8),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.black45, width: 2.0)),
                                    child: Image.asset(
                                      "images/battery.png",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "Electronics",
                                    style: AppWidget.normaltextstyle(20.0),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Color(0xFFececf8),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                            color: Colors.black45, width: 2.0)),
                                    child: Image.asset(
                                      "images/glass.png",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "Glass",
                                    style: AppWidget.normaltextstyle(20.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Schedule a PickUP
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Navigate to the pickup scheduling page
                          },
                          icon: Icon(Icons.add_rounded, color: Colors.white),
                          label: Text("Schedule New Pickup",
                              style: AppWidget.whitetextstyle(18.0)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CAF50),
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 5.0,
                            shadowColor: Colors.green.withAlpha(100),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Pending Requests",
                          style: AppWidget.healinetextstyle(23.0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black45, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "James St. California, USA",
                                  style: AppWidget.normaltextstyle(20.0),
                                )
                              ],
                            ),
                            Divider(),
                            Image.asset(
                              "images/chips.png",
                              height: 150,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "3",
                                  style: AppWidget.normaltextstyle(24.0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
