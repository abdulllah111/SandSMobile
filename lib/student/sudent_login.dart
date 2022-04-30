import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sands/model/department.dart';
import 'package:sands/model/group.dart';
import 'package:sands/student/main_student.dart';
import 'package:sands/teacher/teacher_login.dart';
import 'package:http/http.dart' as http;
import '../constants/color.dart';


class StudentLogin extends StatelessWidget {


  Group? selgroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color:  Theme.of(context).primaryColor,
          ),
          const TopSginin(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(collback: (Group? value) { selgroup = value; },),
                  InkWell(
                    onTap: () {
                      if(selgroup != null){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainStudent(group: selgroup)));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Войти",
                          style: Theme.of(context).textTheme.displayLarge,
                          
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: Center(child: Text.rich(
                      TextSpan(
                          text: "Авторизоваться как преподаватель? ",
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                                text: "\nАвторизоваться",
                                style: Theme.of(context).textTheme.bodyMedium,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context,
                                        '/teacher');
                                  }),
                          ]),
                    ),)
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}


class InputField extends StatefulWidget {

  final ValueSetter<Group?> collback;

   InputField({required this.collback});
  @override
  _InputFieldState createState() => _InputFieldState();

}

class _InputFieldState extends State<InputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List departments;
  late List groups;
  late Group? selectedGroup = new Group(idgroup: 0, groupName: "groupName", iddepartment: 1);
  late var selecteddep;
  var groupsIsEnabled = false;
  Future getGroupsData() async {
    if (selecteddep != null) {
      var responce = await http.get(Uri.https('abdul-arabp.site',
          '/restapi/public/api/department/${selecteddep.iddepartment}/groups'));
      setState(() {
        groups = groupFromJson(responce.body);
      });
      return groupFromJson(responce.body);
    }
  }
  
  Future getDepartmentsData() async {
    var responce = await http
        .get(Uri.https('abdul-arabp.site', '/restapi/public/api/department'));
    setState(() {
      departments = departmentFromJson(responce.body);
    });
    return departmentFromJson(responce.body);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getDepartmentsData();
    selecteddep = new Department(iddepartment: 0, departmentName: "Отделение");
    selectedGroup = new Group(idgroup: 0, groupName: "Группа", iddepartment: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 200,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            "Выберите отделение",
            style:  Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(5),
          ),
            margin: EdgeInsets.only(top: 5, bottom: 35, left: 20, right: 20),
            padding: EdgeInsets.only(left: 0),
            child: Row(
              children: [
                PopupMenuButton(
                  
                  color: Theme.of(context).primaryColorDark.withOpacity(0.0),
                  
                  position: PopupMenuPosition.under,
                  itemBuilder: (BuildContext context) => departments
                      .map((item) => PopupMenuItem(
                        child: Center(child: Container(
                                width: 400,
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                                  // border: Border.all(
                                  //   width: 1,
                                  // ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:
                                    Text(item.departmentName, softWrap: true)
                                )),
                            value: item,
                          )
                          )
                      .toList(),
                  onSelected: (value) {
                    setState(() {
                      selecteddep = value;
                      groupsIsEnabled = true;
                      getGroupsData();
                    });
                  },
                ),
                Flexible(
                  child: Text(
                    selecteddep.departmentName,
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true,
                    maxLines: 4,
                  ),
                )
              ],
            )),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text("Выберите группу",
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(5),
          ),
            margin: EdgeInsets.only(top: 5, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                PopupMenuButton(
                  position: PopupMenuPosition.under,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.0),
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context) => groups
                      .map((item) => PopupMenuItem(
                            enabled: groupsIsEnabled,
                            child: Container(
                                width: 100,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight.withOpacity(0.9),
                                  // border: Border.all(
                                  //   width: 1,
                                  // ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  item.groupName,
                                  softWrap: true,
                                )),
                            value: item,
                          ))
                      .toList(),
                  onSelected: (value) {
                    setState(() {
                      selectedGroup = value as Group?;
                    });
                    widget.collback(this.selectedGroup);
                  },
                ),
                Flexible(
                  child: Text(
                    selectedGroup?.groupName ?? "",
                    style: groupsIsEnabled
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                    maxLines: 4,
                  ),
                )
              ],
            )),
      ],
    );
  }
}

// ignore: must_be_immutable

class TopSginin extends StatelessWidget {
  const TopSginin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25, left: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Text(
              "Студент",
              style: Theme.of(context).textTheme.displayMedium,
            )
          ],
        )
    );
  }
}
