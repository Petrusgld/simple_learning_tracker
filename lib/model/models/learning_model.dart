import 'package:firebase_database/firebase_database.dart';

class LearningModel {
  String id;
  String subject;
  String? description;
  String? dueDate;
  String? startTime;
  String? endTime;
  String? priority;
  String targetHour;
  String currentHour;
  String createdAt;

  LearningModel({
    required this.id,
    required this.subject,
    this.description,
    this.dueDate,
    this.startTime,
    this.endTime,
    this.priority,
    required this.targetHour,
    required this.currentHour,
    required this.createdAt,
  });

  // FROM REALTIME DATABASE - Updated untuk handle data dari CreateController
  factory LearningModel.fromRealtime(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;

    return LearningModel(
      id: snapshot.key ?? '',
      // CreateController menyimpan dengan key 'title', bukan 'subject'
      subject: data['title'] ?? data['subject'] ?? '',
      // CreateController menyimpan dengan key 'desc', bukan 'description'
      description: data['desc'] ?? data['description'],
      // CreateController menyimpan dengan key 'date', bukan 'dueDate'
      dueDate: data['date'] ?? data['dueDate'],
      // CreateController menyimpan dengan key 'start', bukan 'startTime'
      startTime: data['start'] ?? data['startTime'],
      // CreateController menyimpan dengan key 'end', bukan 'endTime'
      endTime: data['end'] ?? data['endTime'],
      priority: data['priority'],
      targetHour: data['targetHour'] ?? '0',
      currentHour: data['currentHour'] ?? '0',
      createdAt: data['createdAt'] ?? '',
    );
  }

  // TO REALTIME DATABASE
  Map<String, dynamic> toMap() {
    return {
      "title": subject,
      "desc": description,
      "date": dueDate,
      "start": startTime,
      "end": endTime,
      "priority": priority,
      "targetHour": targetHour,
      "currentHour": currentHour,
      "createdAt": createdAt,
    };
  }
}