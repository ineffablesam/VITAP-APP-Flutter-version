import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? title;
  String? description;
  String? date;
  String? timestamp;

  NotificationModel({
    this.title,
    this.description,
    this.date,
    this.timestamp
  });


  factory NotificationModel.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return NotificationModel(
      title: d['title'],
      description: d['description'],
      date: d['date'],
      timestamp: d['timestamp'],
    );
  }
}