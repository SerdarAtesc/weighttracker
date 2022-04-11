import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weighttracker/pages/LoginPage.dart';
import 'package:weighttracker/pages/Weights.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //User will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => Weights(
            userid: user.uid,
          ));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User Message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account Creation Failed",
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ));
    }
  }

  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User Message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login Failed",
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
