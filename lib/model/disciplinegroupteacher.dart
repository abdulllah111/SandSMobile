import 'package:sands/model/discipline.dart';
import 'package:sands/model/group.dart';
import 'package:sands/model/teacher.dart';

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
