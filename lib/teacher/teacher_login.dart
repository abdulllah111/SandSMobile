import 'dart:convert';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sands/model/teacher.dart';
import 'package:sands/student/sudent_login.dart';
import 'package:sands/teacher/ttableteacher.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:sands/teacher/teacher_main.dart';

import '../constants/color.dart';



class TeacherLogin extends StatelessWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
          ),
          const TopSginup(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColorDark,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: Center(child: Text.rich(
                      TextSpan(
                          text: "Авторизоваться как студент?",
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                                text: "\nАвторизоваться",
                                style: Theme.of(context).textTheme.bodyMedium,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context,
                                        '/student');
                                    print("Студент");
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
  
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _visible = true;
  bool? isCheck;
  late String login;
  late String password;
  late Teacher? teacher;
  late String? token;
  
  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
    teacher = new Teacher(idteacher: 0, name: '');
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Логин
        Container(
          margin: const EdgeInsets.only(
            top: 200,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            "Логин",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  
                  hintText: "Введите логин",
                  border: InputBorder.none,
                ),
               onChanged: (value){
                 setState(() {
                   login = value;
                 });
               },
              ),
            )
          ),
          //Пароль
          Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            "Пароль",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            // border: Border.all(
            //   width: 1,
            // ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              obscureText: _visible,
              decoration: InputDecoration(
                hintText: "Введите пароль",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                   _visible ? Icons.visibility : Icons.visibility_off
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = !_visible;
                    });
                  }
                )
              ),
              onChanged: (value){
                 setState(() {
                   password = value;
                 });
               },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: isCheck,
                  checkColor: Theme.of(context).primaryColorLight, // color of tick Mark
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    setState(() {
                      isCheck = val!;
                      print(isCheck);
                    });
                  }),
              Text.rich(
                TextSpan(
                    text: "Запомнить меня?",
                    style:Theme.of(context).textTheme.bodyLarge,),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            if(login!="" && password != ""){
              var add = "";
              var client = http.Client();
              Teacher? _teacher;
              try {
                var response = await client.post(
                    Uri.https('abdul-arabp.site', '/restapi/public/api/teacher/login'),
                    body: {'login': login, 'password': password});
                    _teacher = Teacher.fromJson(json.decode(response.body));
              } finally {
                client.close();
              }

              setState(() {
                teacher = _teacher;
              });
            }
            if(teacher != null){
            if(isCheck == true){
              Hive.box<Teacher>('teacher').add(teacher!);
              
            }
              
            Navigator.pushReplacementNamed(
                                        context,
                                        '/mainteacher',
                                        arguments: teacher);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            margin: const EdgeInsets.only(left: 20, right: 20),
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
      ],
    );
  }
}

class TopSginup extends StatelessWidget {
  const TopSginup({
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
            "Преподаватель",
            style: Theme.of(context).textTheme.displayMedium,
          )
        ],
      ),
    );
  }
}
