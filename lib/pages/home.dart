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
      body: Container( child: Column(children: [
        Row(
          children: [
            Text("Hello, ", style: AppWidget.greentextstyle(20.0)),
          ],
        )
      ],),
      ),
    );
  }
}