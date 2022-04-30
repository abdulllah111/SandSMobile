import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sands/model/group.dart';
import 'package:sands/model/teacher.dart';
import 'package:hive/hive.dart';


class StudentDraver extends StatelessWidget {
  const StudentDraver({Key? key, required this.group}) : super(key: key);
  final Group? group;
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
                      group!.groupName,
                      style: Theme.of(context).textTheme.displayLarge
                    ),
            ),
            MenuItem(
              enabled: true,
              icon: Icon(Icons.table_chart),
              title: 'Расписание',
              onTap: () {Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, '/ttablestudent', arguments: group );},
            ),
            MenuItem(
              enabled: true,
              icon: Icon(Icons.timelapse),
              title: 'Замены',
              onTap: () {Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, '/subttablestudent', arguments: group );},
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
                if(Hive.box<Group>('group').length != 0){
                  Hive.box<Group>('group').deleteAt(0);
                  Navigator.pushReplacementNamed(
                      context, '/student');
                }
                else{
                  Navigator.pushReplacementNamed(
                      context, '/student');
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