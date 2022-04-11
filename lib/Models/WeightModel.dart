// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class WeightsModel {
  final String id;
  final String userId;
  final String weight;
  final Timestamp createTime;

  WeightsModel({
    required this.id,
    required this.userId,
    required this.weight,
    required this.createTime,
  });

  factory WeightsModel.createDocument(DocumentSnapshot doc) {
    return WeightsModel(
      id: doc.id,
      userId: doc["userId"],
      weight: doc["weight"],
      createTime: doc["createDate"],
    );
  }
}
