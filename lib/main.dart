

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sands/model/teacher.dart';
import 'package:sands/student/sudent_login.dart';
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
    return AdaptiveTheme(
        dark: DarkTheme,
        light: LightTheme, 
        initial: AdaptiveThemeMode.light, 
        builder: (DarkTheme, LightTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: DarkTheme,
          initialRoute: '/student',
          routes: {
            '/student':(context) => Hive.box<Teacher>('teacher').length == 0 ? StudentLogin() : MainTeacher(teacher: Hive.box<Teacher>('teacher').get(0)),
            '/teacher':(context) => TeacherLogin(),
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
        }
      )
    );
    
  }
}