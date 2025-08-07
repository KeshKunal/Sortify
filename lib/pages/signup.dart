import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sortify/pages/login.dart';
import 'package:sortify/services/widget_support.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
    String email = "", password = "", name = "";

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  // The main registration logic
  registration() async {
    // Check if the fields are not empty before proceeding
    if (passwordcontroller.text.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        mailcontroller.text.isNotEmpty) {
      try {
        // Await the creation of a new user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: mailcontroller.text, password: passwordcontroller.text);

        // If successful, show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase authentication errors
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account Already exists",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(221, 225, 226, 225),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  Image.asset(
                    "images/login2.png",
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.8,
                  left: 25.0,
                  right: 25.0),
              child: Material(
                elevation: 3.0,
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                          child: Text("Create Account",
                              style: AppWidget.blacktextstyle(25.0))),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Name", style: AppWidget.signupTextStyle(20.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Name",
                              prefixIcon: Icon(Icons.person_outline)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Email", style: AppWidget.signupTextStyle(20.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Email",
                              prefixIcon: Icon(Icons.email_outlined)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Password", style: AppWidget.signupTextStyle(20.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFececf8),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              prefixIcon: Icon(Icons.password_outlined)),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Container(
                          height: 45.0,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: Text(
                              "SIGNUP",
                              style: AppWidget.whitetextstyle(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: AppWidget.lighttextstyle(15.0),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              "Login",
                              style: AppWidget.blacktextstyle(20.0),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
