import 'package:flutter/material.dart';
import 'package:sortify/services/widget_support.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23.0),
                  child: Text("Hello, ", style: AppWidget.blacktextstyle(25.0)),
                ),
                Text(
                  "Keshav!",
                  style: AppWidget.greentextstyle(30.0),
                ),
                Spacer(),
                // A profile icon
                Padding(
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
                )
              ],
            ),
            SizedBox(height: 40.0),
            // -- CENTRAL ILLUSTRATION --
            Center(
              child: Transform.rotate(
                angle: -0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 212, 204, 204),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0)
                            .withAlpha(25), // ~10% opacity
                        blurRadius: 15,
                        offset: Offset(4, 10),
                      )
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                  child: Image.asset(
                    "images/home1.png",
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
