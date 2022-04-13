// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';

// Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

class Teacher {
    Teacher({
        required this.idteacher,
        required this.name,
        this.login,
        this.password,
    });

    int idteacher;
    String name;
    dynamic login;
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
