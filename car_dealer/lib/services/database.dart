import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  Future<bool> userExists(String phonenum) async {
    bool retVal = true;
    // QuerySnapshot user =
     await FirebaseFirestore.instance
        .collection('Users')
        .where('phonenum', isEqualTo: phonenum)
        .get()
        .then((item) {
      if (item.docs.isEmpty) {
        retVal = false;
      }
    });
    return retVal;
  }

  Future<void> storeUserDetails(User _user, String username, String phonenum,
      bool admin, String email, String date) async {
    return FirebaseFirestore.instance.collection('Users').doc(_user.uid).set(
        {'username': username, 'phonenum': phonenum, 'admin': admin, 'email': email, 'date': date});
  }
}
