// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String id;
  final String? userName;
  final String? email;
  Users({required this.id, required this.userName, required this.email});

  factory Users.productFromFirebase(User users) {
    return Users(
      id: users.uid,
      userName: users.displayName,
      email: users.email,
    );
  }
  factory Users.createDocument(DocumentSnapshot doc) {
    return Users(
      id: doc.id,
      userName: doc['userName'],
      email: doc['email'],
    );
  }
}
