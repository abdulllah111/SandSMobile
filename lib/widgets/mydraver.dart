import 'package:flutter/material.dart';
import 'package:sands/model/teacher.dart';
import 'package:hive/hive.dart';


class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key, required this.teacher}) : super(key: key);
  final Teacher? teacher;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Расписание'),
            onTap: () {Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, '/ttableteacher', arguments: teacher );},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Замены'),
            onTap: () {Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, '/subttableteacher', arguments: teacher );},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              if(Hive.box<Teacher>('teacher').length != 0){
                Hive.box<Teacher>('teacher').deleteAt(0);
                Navigator.pushReplacementNamed(
                    context, '/teacher');
              }
              else{
                Navigator.pushReplacementNamed(
                    context, '/teacher');
              }
            },
          ),
        ],
      ),
    );
  }
}