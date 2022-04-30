import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sands/model/teacher.dart';
import 'package:hive/hive.dart';


class TeacherDraver extends StatelessWidget {
  const TeacherDraver({Key? key, required this.teacher}) : super(key: key);
  final Teacher? teacher;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.only(top: 60, left: 20),
              child: Text(
                      teacher!.name,
                      style: Theme.of(context).textTheme.displayLarge
                    ),
            ),
            MenuItem(
              enabled: true,
              icon: Icon(Icons.table_chart),
              title: 'Расписание',
              onTap: () {Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, '/ttableteacher', arguments: teacher );},
            ),
            MenuItem(
              enabled: true,
              icon: Icon(Icons.timelapse),
              title: 'Замены',
              onTap: () {Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, '/subttableteacher', arguments: teacher );},
            ),
            MenuItem(
              enabled: false,
              icon: Icon(Icons.group),
              title: 'Кураторство',
              onTap: () {},
            ),
            
          ],
        ),
        bottomNavigationBar: MenuItem(
              enabled: true,
              icon: Icon(Icons.exit_to_app),
              title: 'Выйти',
              color: Theme.of(context).disabledColor,
              onTap: () 
              {
                if(Hive.box<Teacher>('teacher').length != 0){
                  Hive.box<Teacher>('teacher').deleteAt(0);
                  Navigator.pushReplacementNamed(
                      context, '/teacher');
                }
                else{
                  Navigator.pushReplacementNamed(
                      context, '/teacher');
                }
              }
            ),
      )
    );
  }
}


class MenuItem extends StatelessWidget {
  const MenuItem({ Key? key, required this.title, required this.icon, required this.onTap, required this.enabled, this.color}) : super(key: key);

  final String title;
  final Icon icon;
  final Function()? onTap;
  final bool enabled;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 20, bottom: 20),
        decoration: enabled ? 
        BoxDecoration(
          color: color==null ? Theme.of(context).primaryColorLight : color!,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ) :
        BoxDecoration(
          color: color==null ?  Theme.of(context).primaryColorLight.withOpacity(0.5) : color!.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: ListTile(
          enabled: enabled,
          leading: icon,
          title: Text(title, style: enabled ? Theme.of(context).textTheme.bodyMedium : TextStyle(
            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.2),
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize
          )),
          onTap: onTap
        ),
      ),
      
    );
  }
}