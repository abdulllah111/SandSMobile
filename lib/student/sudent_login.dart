import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/model/department.dart';
import 'package:flutter_application_1/model/group.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/services/ModelFromApi.dart';
import 'package:flutter_application_1/student/main_student.dart';
import 'package:flutter_application_1/teacher/teacher_login.dart';
import 'package:http/http.dart' as http;


class Signin extends StatelessWidget {


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
            color: blue,
          ),
          const TopSginin(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: whiteshade,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.09,
                        bottom: 50),
                    child: Image.asset("assets/images/login.png"),
                  ),
                  InputField(collback: (Group? value) { selgroup = value; },),
                  InkWell(
                    onTap: () {
                      if(selgroup != null){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainStudent(group: selgroup)));
                        print("Sign up click");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: whiteshade),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.149,
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: Text.rich(
                      TextSpan(
                          text: "Авторизоваться как преподаватель? ",
                          style: TextStyle(
                              color: grayshade.withOpacity(0.8), fontSize: 16),
                          children: [
                            TextSpan(
                                text: "\nАвторизоваться",
                                style: TextStyle(color: blue, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SignUp()));
                                    print("Sign Up click");
                                  }),
                          ]),
                    ),
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

class CheckerBox extends StatefulWidget {
  const CheckerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckerBox> createState() => _CheckerBoxState();
}

class _CheckerBoxState extends State<CheckerBox> {
  bool? isCheck;

  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              value: isCheck,
              checkColor: whiteshade, // color of tick Mark
              activeColor: blue,
              onChanged: (val) {
                setState(() {
                  isCheck = val!;
                  print(isCheck);
                });
              }),
          Text.rich(
            TextSpan(
              text: "Remember me",
              style: TextStyle(color: grayshade.withOpacity(0.8), fontSize: 16),
            ),
          ),
        ],
      ),
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
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: const Text(
            "Выберите отделение",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 19,
                fontWeight: FontWeight.normal),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 35),
            padding: EdgeInsets.only(left: 0),
            child: Row(
              children: [
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => departments
                      .map((item) => PopupMenuItem(
                            child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: grayshade.withOpacity(0.5),
                                  // border: Border.all(
                                  //   width: 1,
                                  // ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:
                                    Text(item.departmentName, softWrap: true)),
                            value: item,
                          ))
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
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
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
          child: const Text("Выберите группу",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 19,
                  fontWeight: FontWeight.normal)),
        ),
        Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                PopupMenuButton(
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
                                  color: grayshade.withOpacity(0.5),
                                  // border: Border.all(
                                  //   width: 1,
                                  // ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  item.groupName,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
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
                        ? const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)
                        : const TextStyle(
                            color: Colors.black54,
                            fontSize: 19,
                            fontWeight: FontWeight.normal),
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
class InputFields extends StatelessWidget {
  String headerText;
  String hintTexti;

  InputFields({Key? key, required this.headerText, required this.hintTexti})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: grayshade.withOpacity(0.5),
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintTexti,
                  border: InputBorder.none,
                ),
              ),
            )
            //IntrinsicHeight

            ),
      ],
    );
  }
}

class TopSginin extends StatelessWidget {
  const TopSginin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15, left: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_back_sharp,
              )
            ]));
  }
}
