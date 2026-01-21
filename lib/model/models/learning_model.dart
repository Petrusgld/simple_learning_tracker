class LearningModel {

  String id;
  String subject;
  String targetHour;
  String currentHour;
  String createdAt;

  LearningModel({
    required this.id,
    required this.subject,
    required this.targetHour,
    required this.currentHour,
    required this.createdAt,
  });

  factory LearningModel.fromMap(String id, Map data) {
    return LearningModel(
      id: id,
      subject: data['subject'] ?? '',
      targetHour: data['targetHour'] ?? '0',
      currentHour: data['currentHour'] ?? '0',
      createdAt: data['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subject": subject,
      "targetHour": targetHour,
      "currentHour": currentHour,
      "createdAt": createdAt,
    };
  }
}
