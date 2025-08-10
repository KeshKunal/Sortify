import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sortify/services/database.dart';
import 'package:sortify/services/widget_support.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({super.key});

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  Stream? approvalStream;

  getontheload() async {
    approvalStream = await DatabaseMethod().getAdminApproval();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Future<String> getUserPoints(String docId) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(docId).get();

      if (docSnapshot.exists) {
        // Get 'userpoints' field as String (convert if it's int)
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

  Widget allApprovals() {
    return StreamBuilder(
      stream: approvalStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black45, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Image.asset(
                                  "images/coca.png",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // ... inside the first Row
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                // Wrap the Column with Expanded
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.green,
                                          size: 28.0,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          ds["Name"],
                                          style:
                                              AppWidget.normaltextstyle(20.0),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                          size: 28.0,
                                        ),
                                        SizedBox(width: 10.0),
                                        Expanded(
                                          // This Expanded now works because its parent Column has a defined width.
                                          // I've also removed the FittedBox for better text wrapping.
                                          child: Text(
                                            ds["Address"],
                                            style:
                                                AppWidget.normaltextstyle(15.0),
                                            // No maxLines or overflow needed, it will wrap automatically
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.inventory,
                                          color: Colors.green,
                                          size: 25.0,
                                        ),
                                        SizedBox(width: 10.0),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Text(
                                            ds["Quantity"],
                                            style:
                                                AppWidget.normaltextstyle(20.0),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    GestureDetector(
                                      onTap: () async {
                                        String userpoints =
                                            await getUserPoints(ds["UserId"]);
                                        int updatedpoints =
                                            int.parse(userpoints) + 100;
                                        await DatabaseMethod().updateUserPoints(
                                            ds["UserId"], updatedpoints.toString());
                                        await DatabaseMethod()
                                            .updateAdminRequest(ds.id);
                                        await DatabaseMethod()
                                            .updateUserRequest(
                                                ds["UserId"], ds.id);
                                      },
                                      child: Container(
                                        height: 40.0,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 38, 0, 255),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text(
                                            "APPROVE",
                                            style:
                                                AppWidget.whitetextstyle(15.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
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
                  Center(
                    child: Text(
                      "Admin Approval",
                      style: AppWidget.healinetextstyle(25.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        color: Color.fromARGB(98, 179, 182, 184)),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: allApprovals()),
                        ]))))
          ],
        ),
      ),
    );
  }
}
