import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../view/auth/login.dart';

class AuthService {
  static Future<void> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signUp(
      {required String email, required String password, required String fullName}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'uid': userCredential.user!.uid,
        'createdAt': DateTime.now(),
      });
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }


  static Future<void> logOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      Get.offAll(()=>LoginScreen()); // Navigate to Login screen after logout
    } catch (e) {
      Get.snackbar("Error", "Logout failed: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}