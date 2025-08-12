import 'package:flutter/material.dart';
import 'package:sortify/pages/login.dart';
import 'package:sortify/services/auth.dart';
import 'package:sortify/services/shared_pref.dart';
import 'package:sortify/services/widget_support.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // State variables to hold user data
  String? name, email;
  bool _isLoading = true;

  // Function to fetch data from SharedPreferences
  Future<void> ontheload() async {
    name = await SharedpreferenceHelper().getUserName();
    email = await SharedpreferenceHelper().getUserEmail();
    setState(() {
      _isLoading = false; // Stop loading once data is fetched
    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  // A helper function to build reusable info rows
  Widget _buildInfoRow(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 28.0),
          SizedBox(width: 15.0),
          Expanded(
            // Use Expanded to prevent text overflow
            child: Text(
              text,
              style: AppWidget.normaltextstyle(20.0),
            ),
          ),
          Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.black,
                              size: 28.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "User Profile",
                            style: AppWidget.healinetextstyle(30.0),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green.shade100,
                        child: Text(
                          // Show the first letter of the name
                          name![0].toUpperCase(),
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.person_outline, name!),
                          Divider(thickness: 1.0, indent: 10, endIndent: 10),
                          _buildInfoRow(Icons.mail_outline, email!),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Logout Button
                    GestureDetector(
                      onTap: () {
                        AuthMethods().signOut(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 235, 235),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          Icon(Icons.logout_outlined,
                              color: Colors.black, size: 28.0),
                          SizedBox(width: 15.0),
                          Text("LogOut",
                              style: AppWidget.normaltextstyle(20.0)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black54),
                        ]),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Delete Account Button
                    GestureDetector(
                      onTap: () async {
                        await AuthMethods().deleteUser(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 235, 235),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          Icon(Icons.delete_outline,
                              color: Colors.black, size: 28.0),
                          SizedBox(width: 15.0),
                          Text(
                            "Delete Account",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.black54),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
