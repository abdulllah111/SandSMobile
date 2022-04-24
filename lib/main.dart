

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sands/model/teacher.dart';
import 'package:sands/student/sudent_login.dart';
import 'package:sands/teacher/main_teacher.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sands/teacher/teacher_login.dart';
import 'package:sands/teacher/teacher_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(TeacherAdapter());
  Hive.init(appDocumentDir.path);
  await Hive.openBox<Teacher>('teacher');
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/student',
      routes: {
        '/student':(context) => Hive.box<Teacher>('teacher').length == 0 ? StudentLogin() : MainTeacher(teacher: Hive.box<Teacher>('teacher').get(0)),
        '/teacher':(context) => TeacherLogin(),
      },
    );
  }
}