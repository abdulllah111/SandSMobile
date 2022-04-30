// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';
import 'package:sands/model/disciplinegroupteacher.dart';
import 'package:sands/model/lesson.dart';
import 'package:sands/model/office.dart';
import 'package:sands/model/teacher.dart';
import 'package:sands/model/weekday.dart';

import 'package:sands/model/discipline.dart';
import 'package:sands/model/group.dart';

// To parse this JSON data, do
//
//     final subTTable = subTTableFromJson(jsonString);

List<SubTTable> subTTableFromJson(String str) => List<SubTTable>.from(json.decode(str).map((x) => SubTTable.fromJson(x)));

String subTTableToJson(List<SubTTable> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubTTable {
    SubTTable({
        required this.idsubTtable,
        required this.idweekday,
        required this.idlesson,
        required this.idoffice,
        required this.iddisciplinegroupteacher,
        required this.date,
        required this.weekday,
        required this.lesson,
        required this.office,
        required this.disciplineGroupTeacher,
    });

    int idsubTtable;
    int idweekday;
    int idlesson;
    int idoffice;
    int iddisciplinegroupteacher;
    DateTime date;
    Weekday weekday;
    Lesson lesson;
    Office office;
    DisciplineGroupTeacher disciplineGroupTeacher;

    factory SubTTable.fromJson(Map<String, dynamic> json) => SubTTable(
        idsubTtable: json["idsub_ttable"],
        idweekday: json["idweekday"],
        idlesson: json["idlesson"],
        idoffice: json["idoffice"],
        iddisciplinegroupteacher: json["iddisciplinegroupteacher"],
        date: DateTime.parse(json["date"]),
        weekday: Weekday.fromJson(json["weekday"]),
        lesson: Lesson.fromJson(json["lesson"]),
        office: Office.fromJson(json["office"]),
        disciplineGroupTeacher: DisciplineGroupTeacher.fromJson(json["discipline_group_teacher"]),
    );

    Map<String, dynamic> toJson() => {
        "idsub_ttable": idsubTtable,
        "idweekday": idweekday,
        "idlesson": idlesson,
        "idoffice": idoffice,
        "iddisciplinegroupteacher": iddisciplinegroupteacher,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "weekday": weekday.toJson(),
        "lesson": lesson.toJson(),
        "office": office.toJson(),
        "discipline_group_teacher": disciplineGroupTeacher.toJson(),
    };
}