// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final nowTime = DateTime.now();

  Future<void> registerUser({
    id,
    email,
    userName,
  }) async {
    await _firestore.collection("users").doc(id).set({
      "userName": userName,
      "email": email,
      "createTime": nowTime,
    });
  }
}
