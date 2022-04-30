// To parse this JSON data, do
//
//     final group = groupFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part '../db/group.g.dart';

List<Group> groupFromJson(String str) => List<Group>.from(json.decode(str).map((x) => Group.fromJson(x)));

String groupToJson(List<Group> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class Group {
  Group({
    required this.idgroup,
    required this.groupName,
    required this.iddepartment,
  });

  @HiveField(0)
  int idgroup;
  @HiveField(1)
  String groupName;
  @HiveField(2)
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
