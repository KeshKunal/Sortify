import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sortify/pages/login.dart';
import 'package:sortify/services/database.dart';
import 'package:sortify/services/shared_pref.dart';

class AuthMethods {
  // SIGNOUT METHOD
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login page and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }

  // DELETE USER METHOD
  Future<void> deleteUser(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // await DatabaseMethod().deleteUserData(user.uid);
        await user.delete();
        await signOut(context); 
      }
    } on FirebaseAuthException catch (e) {
      print("Error deleting user: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not delete account: ${e.message}")),
      );
    }
  }
}