class Lesson {
  Lesson({
    required this.idlesson,
    required this.lessonNumber,
  });

  int idlesson;
  String lessonNumber;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    idlesson: json["idlesson"],
    lessonNumber: json["lesson_number"],
  );

  Map<String, dynamic> toJson() => {
    "idlesson": idlesson,
    "lesson_number": lessonNumber,
  };
}