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

  // FROM REALTIME DATABASE
  factory LearningModel.fromRealtime(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;

    return LearningModel(
      id: snapshot.key ?? '',
      subject: data['subject'] ?? '',
      description: data['description'],
      dueDate: data['dueDate'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      priority: data['priority'],
      targetHour: data['targetHour'] ?? '0',
      currentHour: data['currentHour'] ?? '0',
      createdAt: data['createdAt'] ?? '',
    );
  }

  // TO REALTIME DATABASE
  Map<String, dynamic> toMap() {
    return {
      "subject": subject,
      "description": description,
      "dueDate": dueDate,
      "startTime": startTime,
      "endTime": endTime,
      "priority": priority,
      "targetHour": targetHour,
      "currentHour": currentHour,
      "createdAt": createdAt,
    };
  }
}
