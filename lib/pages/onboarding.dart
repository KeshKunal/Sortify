import 'package:flutter/material.dart';
import 'package:sortify/services/widget_support.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Image.asset("images/onboard.png"),
            Image.asset("images/logo.png", width: 300),
            const SizedBox(height: 28.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: Text("Find Trash's Next Chapter!",
                    style: AppWidget.healinetextstyle(25.0)),
              ),
            ),
            SizedBox(height: 30.0),
            Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2.0,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Center(
                    child: Text("Get Started",
                        style: AppWidget.whitetextstyle(24.0))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
