// To parse this JSON data, do
//
//     final tTable = tTableFromJson(jsonString);

import 'dart:convert';

import 'package:sands/model/disciplinegroupteacher.dart';
import 'package:sands/model/lesson.dart';
import 'package:sands/model/office.dart';
import 'package:sands/model/teacher.dart';
import 'package:sands/model/weekday.dart';

import 'package:sands/model/discipline.dart';
import 'package:sands/model/group.dart';



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