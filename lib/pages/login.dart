import 'package:flutter/material.dart';
import 'package:sortify/services/widget_support.dart';
import 'package:sortify/pages/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  height: MediaQuery.of(context).size.height / 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                          child: Text("Welcome Back!",
                              style: AppWidget.blacktextstyle(25.0))),
                      SizedBox(
                        height: 20.0,
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
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: AppWidget.lighttextstyle(15.0),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Container(
                          height: 45.0,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: Text(
                              "LOGIN",
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
                            "Don't have an account?",
                            style: AppWidget.lighttextstyle(15.0),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              "Signup",
                              style: AppWidget.blacktextstyle(18.0),
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
