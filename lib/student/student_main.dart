import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sands/model/group.dart';
import 'package:sands/model/teacher.dart';

import 'package:sands/pages/menu_page.dart';
import 'package:sands/student/ttablestudent.dart';
import 'package:sands/teacher/ttableteacher.dart';

import '../constants/theme.dart';


class MainStudent extends StatelessWidget {
  const MainStudent({Key? key, required this.group}) : super(key: key);
  final Group? group;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            children: <Widget>[
              TtableFromStudent(group: group)
            ],
          ),
        );
  }
}