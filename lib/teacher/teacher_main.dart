import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sands/model/teacher.dart';

import 'package:sands/pages/menu_page.dart';
import 'package:sands/teacher/main_teacher.dart';


class MainTeacher extends StatelessWidget {
  const MainTeacher({Key? key, required this.teacher}) : super(key: key);
  final Teacher? teacher;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Flutter Challenge 6',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            MenuPage(teacher: teacher,),
            TtableFromTeacher(teacher: teacher)
          ],
        ),
      ),
    );
  }
}