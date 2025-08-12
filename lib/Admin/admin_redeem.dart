import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sortify/services/widget_support.dart';
import 'package:sortify/services/database.dart';

class AdminRedeem extends StatefulWidget {
  const AdminRedeem({super.key});

  @override
  State<AdminRedeem> createState() => _AdminRedeemState();
}

class _AdminRedeemState extends State<AdminRedeem> {
  Stream? redeemStream;
  getontheload() async {
    redeemStream = await DatabaseMethod().getAdminRedeemApproval();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allApprovals() {
    return StreamBuilder(
      stream: redeemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              ds["Date"],
                              textAlign: TextAlign.center,
                              style: AppWidget.whitetextstyle(20.0),
                            )),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person,
                                      color: Colors.green, size: 22.0),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.normaltextstyle(20.0),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.money,
                                      color: Colors.green, size: 22.0),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Points : " + ds["Points"],
                                    style: AppWidget.normaltextstyle(20.0),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.account_balance,
                                      color: Colors.green, size: 22.0),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "UPI Id : " + ds["UPI"],
                                    style: AppWidget.normaltextstyle(20.0),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.0),
                              GestureDetector(
                                onTap: () async {
                                  await DatabaseMethod()
                                      .updateAdminRedeemRequest(ds.id);
                                  await DatabaseMethod()
                                      .updateUserRedeemRequest(
                                          ds["UserId"], ds.id);
                                },
                                child: Container(
                                  height: 40,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 38, 0, 255),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Center(
                                    child: Text("APPROVE",
                                        style: AppWidget.whitetextstyle(20.0)),
                                  ),
                                ),
                              )
                            ])
                      ],
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
          child: Column(children: [
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
                      "Redeem Approval",
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
                            height: 20.0,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: allApprovals()),
                        ]))))
          ])),
    );
  }
}
