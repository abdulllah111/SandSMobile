// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

List<Department> departmentFromJson(String str) => List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));
String departmentToJson(List<Department> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
  Department({
    required this.iddepartment,
    required this.departmentName,
  });

  int iddepartment;
  String departmentName;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    iddepartment: json["iddepartment"],
    departmentName: json["department_name"],
  );

  Map<String, dynamic> toJson() => {
    "iddepartment": iddepartment,
    "department_name": departmentName,
  };
}
