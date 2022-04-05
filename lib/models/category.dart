import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? name;
  String? thumbnailUrl;
  String? timestamp;

  CategoryModel({
    this.name,
    this.thumbnailUrl,
    this.timestamp
  });


  factory CategoryModel.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return CategoryModel(
      name: d['name'],
      thumbnailUrl: d['thumbnail'],
      timestamp: d['timestamp'],
    );
  }
}