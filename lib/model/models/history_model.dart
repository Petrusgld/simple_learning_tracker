class HistoryModel {
  String id;
  String subject;
  String targetHour;
  String currentHour;
  String createdAt;
  String completedAt;

  HistoryModel({
    required this.id,
    required this.subject,
    required this.targetHour,
    required this.currentHour,
    required this.createdAt,
    required this.completedAt,
  });

  factory HistoryModel.fromMap(String id, Map data) {
    return HistoryModel(
      id: id,
      subject: data['subject'] ?? '',
      targetHour: data['targetHour'] ?? '0',
      currentHour: data['currentHour'] ?? '0',
      createdAt: data['createdAt'] ?? '',
      completedAt: data['completedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subject": subject,
      "targetHour": targetHour,
      "currentHour": currentHour,
      "createdAt": createdAt,
      "completedAt": completedAt,
    };
  }
}