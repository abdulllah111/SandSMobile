

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sands/model/group.dart';
import 'package:sands/model/teacher.dart';
import 'package:sands/student/student_main.dart';
import 'package:sands/student/sudent_login.dart';
import 'package:sands/student/ttablestudent.dart';
import 'package:sands/teacher/subttableteacher.dart';
import 'package:sands/teacher/ttableteacher.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sands/teacher/teacher_login.dart';
import 'package:sands/teacher/teacher_main.dart';

import 'constants/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(TeacherAdapter());
  Hive.registerAdapter(GroupAdapter());
  Hive.init(appDocumentDir.path);
  await Hive.openBox<Teacher>('teacher');
  await Hive.openBox<Group>('group');
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        dark: DarkTheme,
        light: LightTheme, 
        initial: AdaptiveThemeMode.light, 
        builder: (DarkTheme, LightTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: DarkTheme,
          home:  Hive.box<Teacher>('teacher').length != 0 ?  MainTeacher(teacher: Hive.box<Teacher>('teacher').get(0)) :
          Hive.box<Group>('group').length != 0 ? MainStudent(group: Hive.box<Group>('group').get(0)) : StudentLogin(),
          routes: {
            '/teacher':(context) => TeacherLogin(),
            '/student':(context) =>StudentLogin(),
        },
         onGenerateRoute: (settings) {
           if (settings.name == '/mainteacher') {
            Teacher? teacher = settings.arguments as Teacher?;
            return MaterialPageRoute(
                builder: (context) => MainTeacher(
                      teacher: teacher,
                    ));
          }
          if (settings.name == '/ttableteacher') {
            Teacher? teacher = settings.arguments as Teacher?;
            return MaterialPageRoute(
                builder: (context) => TtableFromTeacher(
                      teacher: teacher,
                    ));
          }
          if (settings.name == '/subttableteacher') {
            Teacher? teacher = settings.arguments as Teacher?;
            return MaterialPageRoute(
                builder: (context) => SubTtableTeacher(
                      teacher: teacher,
                    ));
          }
          if (settings.name == '/mainstudent') {
            Group? group = settings.arguments as Group?;
            return MaterialPageRoute(
                builder: (context) => MainStudent(
                      group: group,
                    ));
          }
          if (settings.name == '/ttablestudent') {
            Group? group = settings.arguments as Group?;
            return MaterialPageRoute(
                builder: (context) => TtableFromStudent(
                      group: group,
                    ));
          }
        }
      )
    );
    
  }
}