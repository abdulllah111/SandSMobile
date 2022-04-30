import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sands/model/teacher.dart';

import 'package:sands/pages/menu_page.dart';
import 'package:sands/teacher/ttableteacher.dart';

import '../constants/theme.dart';


class MainTeacher extends StatelessWidget {
  const MainTeacher({Key? key, required this.teacher}) : super(key: key);
  final Teacher? teacher;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            children: <Widget>[
              TtableFromTeacher(teacher: teacher)
            ],
          ),
        );
  }
}