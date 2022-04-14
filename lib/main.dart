import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/teacher.dart';
import 'package:flutter_application_1/student/sudent_login.dart';
import 'package:flutter_application_1/teacher/main_teacher.dart';
import 'package:flutter_application_1/teacher/teacher_login.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
// var dir = Directory(appDocumentDir.path);
//  await dir.create(recursive: true);
//  Hive
//     ..init(appDocumentDir.path)
//     ..registerAdapter(TeacherAdapter());
  
  Hive.registerAdapter(TeacherAdapter());
  Hive.init('D:/');
  // await Hive.initFlutter('/lib/');
  await Hive.openBox<Teacher>('teacher');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Hive.box<Teacher>('teacher').length == 0 ? StudentLogin() : MainTeacher(teacher: Hive.box<Teacher>('teacher').get(0)),
    );
  }
}