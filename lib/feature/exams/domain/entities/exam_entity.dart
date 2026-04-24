class ExamEntity {
  final String id;
  final String title;
  final String subject;
  final int? duration;
  final int? numberOfQuestions;
  final bool? active;
  final DateTime? createdAt;
  String get startTime {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  String get endTime {
    if (duration != null) {
      final now = DateTime.now();
      final end = now.add(Duration(minutes: duration!));
      return '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
    }
    return startTime;
  }

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

  static final List<ExamEntity> dummyExams = [
    ExamEntity(
      id: '1',
      title: 'Midterm Exam',
      subject: 'Mathematics',
      duration: 90,
      numberOfQuestions: 30,
      active: true,
      createdAt: DateTime(2026, 1, 10),
    ),
    ExamEntity(
      id: '2',
      title: 'Final Exam',
      subject: 'Physics',
      duration: 120,
      numberOfQuestions: 50,
      active: true,
      createdAt: DateTime(2026, 2, 5),
    ),
    ExamEntity(
      id: '3',
      title: 'Quiz 1',
      subject: 'Chemistry',
      duration: 30,
      numberOfQuestions: 15,
      active: false,
      createdAt: DateTime(2026, 3, 1),
    ),
    ExamEntity(
      id: '4',
      title: 'Unit Test',
      subject: 'Biology',
      duration: 60,
      numberOfQuestions: 25,
      active: true,
      createdAt: DateTime(2026, 3, 20),
    ),
    ExamEntity(
      id: '5',
      title: 'Practice Exam',
      subject: 'History',
      duration: 45,
      numberOfQuestions: 20,
      active: false,
      createdAt: DateTime(2026, 4, 1),
    ),
    ExamEntity(
      id: '6',
      title: 'Algebra Test',
      subject: 'Mathematics',
      duration: 75,
      numberOfQuestions: 35,
      active: true,
      createdAt: DateTime(2026, 1, 15),
    ),
    ExamEntity(
      id: '7',
      title: 'Mechanics Quiz',
      subject: 'Physics',
      duration: 40,
      numberOfQuestions: 18,
      active: true,
      createdAt: DateTime(2026, 2, 10),
    ),
    ExamEntity(
      id: '8',
      title: 'Organic Chemistry',
      subject: 'Chemistry',
      duration: 100,
      numberOfQuestions: 40,
      active: true,
      createdAt: DateTime(2026, 3, 5),
    ),
    ExamEntity(
      id: '9',
      title: 'Cell Biology Exam',
      subject: 'Biology',
      duration: 80,
      numberOfQuestions: 28,
      active: false,
      createdAt: DateTime(2026, 3, 25),
    ),
    ExamEntity(
      id: '10',
      title: 'World War II',
      subject: 'History',
      duration: 55,
      numberOfQuestions: 22,
      active: true,
      createdAt: DateTime(2026, 4, 3),
    ),
    ExamEntity(
      id: '11',
      title: 'Calculus Final',
      subject: 'Mathematics',
      duration: 110,
      numberOfQuestions: 45,
      active: true,
      createdAt: DateTime(2026, 1, 20),
    ),
    ExamEntity(
      id: '12',
      title: 'Thermodynamics',
      subject: 'Physics',
      duration: 95,
      numberOfQuestions: 32,
      active: false,
      createdAt: DateTime(2026, 2, 15),
    ),
    ExamEntity(
      id: '13',
      title: 'Periodic Table Quiz',
      subject: 'Chemistry',
      duration: 25,
      numberOfQuestions: 12,
      active: true,
      createdAt: DateTime(2026, 3, 8),
    ),
    ExamEntity(
      id: '14',
      title: 'Genetics Test',
      subject: 'Biology',
      duration: 70,
      numberOfQuestions: 26,
      active: true,
      createdAt: DateTime(2026, 3, 28),
    ),
    ExamEntity(
      id: '15',
      title: 'Ancient Civilizations',
      subject: 'History',
      duration: 50,
      numberOfQuestions: 19,
      active: true,
      createdAt: DateTime(2026, 4, 5),
    ),
    ExamEntity(
      id: '16',
      title: 'Geometry Midterm',
      subject: 'Mathematics',
      duration: 85,
      numberOfQuestions: 33,
      active: false,
      createdAt: DateTime(2026, 1, 25),
    ),
    ExamEntity(
      id: '17',
      title: 'Optics Exam',
      subject: 'Physics',
      duration: 65,
      numberOfQuestions: 24,
      active: true,
      createdAt: DateTime(2026, 2, 20),
    ),
    ExamEntity(
      id: '18',
      title: 'Chemical Reactions',
      subject: 'Chemistry',
      duration: 60,
      numberOfQuestions: 23,
      active: true,
      createdAt: DateTime(2026, 3, 12),
    ),
    ExamEntity(
      id: '19',
      title: 'Ecology Quiz',
      subject: 'Biology',
      duration: 35,
      numberOfQuestions: 16,
      active: true,
      createdAt: DateTime(2026, 4, 1),
    ),
    ExamEntity(
      id: '20',
      title: 'Renaissance Period',
      subject: 'History',
      duration: 48,
      numberOfQuestions: 21,
      active: false,
      createdAt: DateTime(2026, 4, 8),
    ),
    ExamEntity(
      id: '21',
      title: 'Statistics Final',
      subject: 'Mathematics',
      duration: 105,
      numberOfQuestions: 42,
      active: true,
      createdAt: DateTime(2026, 1, 30),
    ),
    ExamEntity(
      id: '22',
      title: 'Electromagnetism',
      subject: 'Physics',
      duration: 90,
      numberOfQuestions: 31,
      active: true,
      createdAt: DateTime(2026, 2, 25),
    ),
    ExamEntity(
      id: '23',
      title: 'Acids and Bases',
      subject: 'Chemistry',
      duration: 55,
      numberOfQuestions: 20,
      active: false,
      createdAt: DateTime(2026, 3, 15),
    ),
    ExamEntity(
      id: '24',
      title: 'Human Anatomy',
      subject: 'Biology',
      duration: 75,
      numberOfQuestions: 29,
      active: true,
      createdAt: DateTime(2026, 4, 2),
    ),
    ExamEntity(
      id: '25',
      title: 'Cold War Era',
      subject: 'History',
      duration: 52,
      numberOfQuestions: 24,
      active: true,
      createdAt: DateTime(2026, 4, 10),
    ),
  ];
}
