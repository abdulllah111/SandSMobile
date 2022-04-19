// To parse this JSON data, do
//
//     final tTable = tTableFromJson(jsonString);

import 'dart:convert';

import 'package:sands/model/teacher.dart';

List<TTable> tTableFromJson(String str) => List<TTable>.from(json.decode(str).map((x) => TTable.fromJson(x)));

String tTableToJson(List<TTable> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TTable {
  TTable({
    required this.idttable,
    required this.idweekday,
    required this.idlesson,
    required this.idoffice,
    required this.iddisciplinegroupteacher,
    required this.weekday,
    required this.lesson,
    required this.office,
    required this.disciplineGroupTeacher,
  });

  int idttable;
  int idweekday;
  int idlesson;
  int idoffice;
  int iddisciplinegroupteacher;
  Weekday weekday;
  Lesson lesson;
  Office office;
  DisciplineGroupTeacher disciplineGroupTeacher;

  factory TTable.fromJson(Map<String, dynamic> json) => TTable(
    idttable: json["idttable"],
    idweekday: json["idweekday"],
    idlesson: json["idlesson"],
    idoffice: json["idoffice"],
    iddisciplinegroupteacher: json["iddisciplinegroupteacher"],
    weekday: Weekday.fromJson(json["weekday"]),
    lesson: Lesson.fromJson(json["lesson"]),
    office: Office.fromJson(json["office"]),
    disciplineGroupTeacher: DisciplineGroupTeacher.fromJson(json["discipline_group_teacher"]),
  );

  Map<String, dynamic> toJson() => {
    "idttable": idttable,
    "idweekday": idweekday,
    "idlesson": idlesson,
    "idoffice": idoffice,
    "iddisciplinegroupteacher": iddisciplinegroupteacher,
    "weekday": weekday.toJson(),
    "lesson": lesson.toJson(),
    "office": office.toJson(),
    "discipline_group_teacher": disciplineGroupTeacher.toJson(),
  };
}

class DisciplineGroupTeacher {
  DisciplineGroupTeacher({
    required this.iddisciplineGroupTeacher,
    required this.idteacher,
    required this.iddiscipline,
    required this.idgroup,
    required this.teacher,
    required this.discipline,
    required this.group,
  });

  int iddisciplineGroupTeacher;
  int idteacher;
  int iddiscipline;
  int idgroup;
  Teacher teacher;
  Discipline discipline;
  Group group;

  factory DisciplineGroupTeacher.fromJson(Map<String, dynamic> json) => DisciplineGroupTeacher(
    iddisciplineGroupTeacher: json["iddiscipline-group-teacher"],
    idteacher: json["idteacher"],
    iddiscipline: json["iddiscipline"],
    idgroup: json["idgroup"],
    teacher: Teacher.fromJson(json["teacher"]),
    discipline: Discipline.fromJson(json["discipline"]),
    group: Group.fromJson(json["group"]),
  );

  Map<String, dynamic> toJson() => {
    "iddiscipline-group-teacher": iddisciplineGroupTeacher,
    "idteacher": idteacher,
    "iddiscipline": iddiscipline,
    "idgroup": idgroup,
    "teacher": teacher.toJson(),
    "discipline": discipline.toJson(),
    "group": group.toJson(),
  };
}

class Discipline {
  Discipline({
    required this.iddiscipline,
    required this.disciplineName,
  });

  int iddiscipline;
  String disciplineName;

  factory Discipline.fromJson(Map<String, dynamic> json) => Discipline(
    iddiscipline: json["iddiscipline"],
    disciplineName: json["discipline_name"],
  );

  Map<String, dynamic> toJson() => {
    "iddiscipline": iddiscipline,
    "discipline_name": disciplineName,
  };
}

class Group {
  Group({
    required this.idgroup,
    required this.groupName,
    required this.iddepartment,
  });

  int idgroup;
  String groupName;
  int iddepartment;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    idgroup: json["idgroup"],
    groupName: json["group_name"],
    iddepartment: json["iddepartment"],
  );

  Map<String, dynamic> toJson() => {
    "idgroup": idgroup,
    "group_name": groupName,
    "iddepartment": iddepartment,
  };
}



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

class Office {
  Office({
    required this.idoffice,
    required this.officeNumber,
  });

  int idoffice;
  String officeNumber;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
    idoffice: json["idoffice"],
    officeNumber: json["office_number"],
  );

  Map<String, dynamic> toJson() => {
    "idoffice": idoffice,
    "office_number": officeNumber,
  };
}

class Weekday {
  Weekday({
    required this.idweekday,
    required this.weekdayName,
  });

  int idweekday;
  String weekdayName;

  factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
    idweekday: json["idweekday"],
    weekdayName: json["weekday_name"],
  );

  Map<String, dynamic> toJson() => {
    "idweekday": idweekday,
    "weekday_name": weekdayName,
  };
}
