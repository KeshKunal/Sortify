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
                  child:
                      Text("Hello, ", style: AppWidget.healinetextstyle(25.0)),
                ),
                Text(
                  "Keshav!",
                  style: AppWidget.greentextstyle(30.0),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Center(
                child:
                    Image.asset("images/home1.png", height: 400.0, width: 320))
          ],
        ),
      ),
    );
  }
}
