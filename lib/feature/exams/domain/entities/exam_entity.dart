class ExamEntity {
  final String id;
  final String title;
  final String subject;
  final int? duration;
  final int? numberOfQuestions;
  final bool? active;
  final DateTime? createdAt;

  ExamEntity({
    required this.id,
    required this.title,
    required this.subject,
    this.duration,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  ExamEntity copyWith({
    String? id,
    String? title,
    String? subject,
    int? duration,
    int? numberOfQuestions,
    bool? active,
    DateTime? createdAt,
  }) {
    return ExamEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      duration: duration ?? this.duration,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

}
