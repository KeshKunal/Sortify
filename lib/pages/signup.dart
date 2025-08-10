import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sortify/pages/home.dart';
import 'package:sortify/pages/login.dart';
import 'package:sortify/services/database.dart';
import 'package:sortify/services/shared_pref.dart';
import 'package:sortify/services/widget_support.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "", password = "", name = "";

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();

  // The main registration logic
  registration() async {
    // The check for empty fields is good.
    if (passwordcontroller.text.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        mailcontroller.text.isNotEmpty) {
      try {
        print("1. Registration button pressed, trying to create user...");
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: mailcontroller.text, password: passwordcontroller.text);

        print("2. User created successfully. UID: ${userCredential.user!.uid}");
        String Id = userCredential.user!.uid;

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Id": Id,
          "Points": "0",
        };

        await SharedpreferenceHelper().saveUserId(Id);
        await SharedpreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedpreferenceHelper().saveUserName(namecontroller.text);
        await DatabaseMethod().addUserDetails(userInfoMap, Id);

        print("3. User data saved. Showing success SnackBar...");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(width: 8.0),
              Text(
                "Registered Successfully",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));

        print("4. Navigating to Home page...");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        print("FIREBASE AUTH ERROR: ${e.code}"); // Print the error code
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password Provided is too Weak")));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Account Already exists")));
        }
      } catch (e) {
        print("AN UNEXPECTED ERROR OCCURRED: $e");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An unknown error occurred: $e")));
      }
    } else {
      print("Validation failed: One or more fields are empty.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return Container(
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0),
                            Center(
                                child: Text("Create Account",
                                    style: AppWidget.blacktextstyle(25.0))),
                            SizedBox(height: 20.0),
                            Text("Name",
                                style: AppWidget.signupTextStyle(20.0)),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFececf8),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: TextField(
                                controller: namecontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Name",
                                    prefixIcon: Icon(Icons.person_outline)),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text("Email",
                                style: AppWidget.signupTextStyle(20.0)),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFececf8),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: TextField(
                                controller: mailcontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Email",
                                    prefixIcon: Icon(Icons.email_outlined)),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text("Password",
                                style: AppWidget.signupTextStyle(20.0)),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFececf8),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: TextField(
                                obscureText: true,
                                controller: passwordcontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Password",
                                    prefixIcon: Icon(Icons.password_outlined)),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (namecontroller.text != "" &&
                                      mailcontroller.text != "" &&
                                      passwordcontroller.text != "") {
                                    setState(() {
                                      name = namecontroller.text;
                                      email = mailcontroller.text;
                                      password = passwordcontroller.text;
                                    });
                                    registration();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  fixedSize: const Size(150, 45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: Text(
                                  "SIGNUP",
                                  style: AppWidget.whitetextstyle(20.0),
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
                                // If Signup is successful, navigate to the login page
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
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
