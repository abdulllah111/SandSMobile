// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part '../db/teacher.g.dart';

// Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class Teacher {
    Teacher({
        required this.idteacher,
        required this.name,
        this.login,
        this.password,
    });

    @HiveField(0)
    int idteacher;
    @HiveField(1)
    String name;
    @HiveField(2)
    dynamic login;
    @HiveField(3)
    dynamic password;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        idteacher: json["idteacher"] == null ? null : json["idteacher"],
        name: json["name"] == null ? null : json["name"],
        login: json["login"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "idteacher": idteacher == null ? null : idteacher,
        "name": name == null ? null : name,
        "login": login,
        "password": password,
    };
}
