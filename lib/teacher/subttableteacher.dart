
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:sands/model/Ttable.dart';
import 'package:sands/model/subttable.dart';
import 'package:sands/model/teacher.dart' as tch;
import 'package:sands/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:sands/pages/menu_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../widgets/myappbar.dart';
import '../widgets/myteacherdraver.dart';


class SubTtableTeacher extends StatefulWidget {
  const SubTtableTeacher({Key? key, required this.teacher}) : super(key: key);
  final tch.Teacher? teacher;
  @override
  _MainTeacherState createState() => _MainTeacherState(teacher);
}



class _MainTeacherState extends State<SubTtableTeacher> with SingleTickerProviderStateMixin {
  late List<SubTTable> subTTables = [];
  final tch.Teacher? teacher;

   void toggle() {
   
  }

  _MainTeacherState(this.teacher);

  

  Future getSubTTables() async {
    var responce1 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/subttable/getforteacher/${teacher?.idteacher}'));
    setState(() {
      subTTables = subTTableFromJson(responce1.body);
    });
  }
  void initState() {

    subTTables = [];
    getSubTTables();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TeacherDraver(teacher: teacher,),
          backgroundColor: Theme.of(context).primaryColorDark,
            appBar: MyAppBar(toggle: toggle, title: "Замены",),
            body: Container(
              child: Center (
                child: subTTables.isEmpty ? CircularProgressIndicator() : AnimatedSwitcher(
                  switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                    child: SfDataGrid(
                    allowSwiping: false,
                  
                    columnWidthMode: ColumnWidthMode.fill,
                    rowHeight: 70.0,
                    headerRowHeight: 60.0,
                    source: new SubTtableDataSource(subTTables: subTTables),
                    // source: new SubTtableDataSource(selectedTtable: selectedTtable),
                    columns: <GridColumn>[
                      GridColumn(columnName: 'Дата', label: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Container(alignment: Alignment.center,
                          child: const Text(
                            'Дата',
                          ),
                        )
                      )),
                      GridColumn(columnName: 'Пара', label: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Container(alignment: Alignment.center,
                          child: const Text(
                            'Пара',
                          ),
                        )
                      )),
                      GridColumn(columnName: 'Предмет', label: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Container(alignment: Alignment.center,
                          child: const Text(
                            'Предмет',
                          ),
                        )
                      )),
                      GridColumn(columnName: 'Группа', label: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'Группа',
                          )
                      )),
                      GridColumn(columnName: 'Группа', label: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          child: Container(alignment: Alignment.center,
                          child: const Text(
                            'Группа',
                          ),
                        )
                      )),
                    ]
                  ),
                )
              ),
            ),
    );
  }
}

class SubTtableDataSource extends DataGridSource {
  SubTtableDataSource({required List<SubTTable> subTTables}) {
    _subttables = subTTables
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Дата', value: '${e.date.day}.${e.date.month}.${e.date.year}'),
      DataGridCell<String>(columnName: 'Пара', value: e.lesson.lessonNumber),
      DataGridCell<String>(columnName: 'Предмет', value: e.disciplineGroupTeacher.discipline.disciplineName),
      DataGridCell<String>(
          columnName: 'Группа', value: e.disciplineGroupTeacher.group.groupName),
      DataGridCell<String>(columnName: 'Кабинет', value: e.office.officeNumber),
    ]))
        .toList();
  }

  List<DataGridRow>  _subttables = [];

  @override
  List<DataGridRow> get rows =>  _subttables;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}
