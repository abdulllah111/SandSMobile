import 'dart:ui';

import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function toggle;
  final String title;
  MyAppBar({required this.toggle, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBar createState() => _MyAppBar(title: title);
}

class _MyAppBar extends State<MyAppBar> {
  _MyAppBar({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      centerTitle: false, 
      // leading: TextButton(
      //     onPressed: () {
      //       widget.toggle();
      //     }, 
      //     child: Icon(
      //         Icons.menu,
      //         color: Theme.of(context).textTheme.displayMedium?.color,
      //         size: 25,
      //       ),
      //     ),
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(title, style: Theme.of(context).textTheme.displayMedium,),
    );
  }
}