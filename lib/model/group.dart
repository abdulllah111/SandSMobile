// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

List<Group> groupFromJson(String str) => List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
