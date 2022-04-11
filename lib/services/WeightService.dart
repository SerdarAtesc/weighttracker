// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weighttracker/Models/WeightModel.dart';

class WeightService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost({
    weight,
    userId,
  }) async {
    await _firestore.collection("weights").add({
      "weight": weight,
      "userId": userId,
      "createDate": DateTime.now(),
    });
  }


  Stream<QuerySnapshot> getWeightsbyUser(userId) {
    Stream<QuerySnapshot> q1 = _firestore
        .collection("weights")
        .where("userId", isEqualTo: userId)
        .orderBy("createDate", descending: true)
        .snapshots();

    return q1;
  }

  Future<void> weightDelete({WeightsModel? weight}) async {
    _firestore
        .collection("weights")
        .doc(weight?.id)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  void weightUpdate({String? id, String? weight}) {
    _firestore
        .collection("weights")
        .doc(id)
        .update({"id": id, "weight": weight, "createDate": DateTime.now()});
  }
}
