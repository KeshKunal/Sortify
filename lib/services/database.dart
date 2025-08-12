import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserUploadItem(
      Map<String, dynamic> userInfoMap, String id, String itemid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Items")
        .doc(itemid)
        .set(userInfoMap);
  }

  Future addadminItem(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Requests")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAdminApproval() async {
    return await FirebaseFirestore.instance
        .collection("Requests")
        .where("Status", isEqualTo: "Pending")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserTransactions(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Redeem")
        .snapshots();
  }

   Future<Stream<QuerySnapshot>> getAdminRedeemApproval() async {
    return await FirebaseFirestore.instance
        .collection("Redeem")
        .where("Status", isEqualTo: "Pending")
        .snapshots();
  }

  Future updateAdminRequest(
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Requests")
        .doc(id)
        .update({"Status": "Approved"});
  }

  Future updateUserRequest(String id, String itemid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Items")
        .doc(itemid)
        .update({"Status": "Approved"});
  }
 Future updateAdminRedeemRequest(
    String id,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Redeem")
        .doc(id)
        .update({"Status": "Approved"});
  }

 Future updateUserRedeemRequest(String id, String itemid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Redeem")
        .doc(itemid)
        .update({"Status": "Approved"});
  }

  Future updateUserPoints(String id, String points) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Points": points});
  }

  Future addUserRedeemPoints(
      Map<String, dynamic> userInfoMap, String id, String redeemid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Redeem")
        .doc(redeemid)
        .set(userInfoMap);
  }

  Future addAdminRedeemRequests(
      Map<String, dynamic> userInfoMap, String redeemid) async {
    return await FirebaseFirestore.instance
        .collection("Redeem")
        .doc(redeemid)
        .set(userInfoMap);
  }

  Future<String?> getUserPointsById(String id) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data["Points"]?.toString();
      }
    } catch (e) {
      print("Error fetching user points: $e");
    }
    return "0";
  }
}
