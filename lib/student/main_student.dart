import 'dart:convert';
import 'dart:ui';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:sands/constants/text_style.dart';

import 'package:sands/model/Ttable.dart';
import 'package:sands/model/group.dart' as gr;
import 'package:sands/widgets/custom_paint.dart';
import 'package:sands/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MainStudent extends StatefulWidget {
  const MainStudent({Key? key, required this.group}) : super(key: key);
  final gr.Group? group;
  @override
  _MainStudentState createState() => _MainStudentState(group);
}


class _MainStudentState extends State<MainStudent> {
  int selectBtn = 0;
  late List<TTable> ponedelnik;
  late List<TTable> vtornik;
  late List<TTable> sreda;
  late List<TTable> tchetverg;
  late List<TTable> piatnica;
  late List<TTable> subbota;
  List<TTable> selectedTtable = [];

  final gr.Group? group;
  _MainStudentState(this.group);

  Future getGroupsData() async {
    var responce1 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforgroup/${group?.idgroup}/1'));
    var responce2 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforgroup/${group?.idgroup}/2'));
    var responce3 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforgroup/${group?.idgroup}/3'));
    var responce4 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforgroup/${group?.idgroup}/4'));
    var responce5 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforgroup/${group?.idgroup}/5'));
    var responce6 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforgroup/${group?.idgroup}/6'));
    setState(() {
      ponedelnik = tTableFromJson(responce1.body);
      vtornik = tTableFromJson(responce2.body);
      sreda = tTableFromJson(responce3.body);
      tchetverg = tTableFromJson(responce4.body);
      piatnica = tTableFromJson(responce5.body);
      subbota = tTableFromJson(responce6.body);
      selectedTtable = ponedelnik;
    });
  }
  void initState() {
    super.initState();
    ponedelnik = [];
    selectedTtable = [];
    getGroupsData();
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index){
        case 0:
          selectedTtable = ponedelnik;
          break;
        case 1:
          selectedTtable = vtornik;
          break;
        case 2:
          selectedTtable = sreda;
          break;
        case 3:
          selectedTtable = tchetverg;
          break;
        case 4:
          selectedTtable = piatnica;
          break;
        case 5:
          selectedTtable = subbota;
          break;
      }
      // _child = AnimatedSwitcher(
      //   switchInCurve: Curves.easeOut,
      //   switchOutCurve: Curves.easeIn,
      //   duration: Duration(milliseconds: 500),
      //   child: _child,
      // );
    });
  }

  // ttable/getforgroup/{id}/{weekday}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Расписание для группы ${group?.groupName}"),
      ),
      body: Container(
        child: Center (
          child: selectedTtable.isEmpty ? CircularProgressIndicator(

          ) : AnimatedSwitcher(switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            child: SfDataGrid(
              onSwipeStart: (e) {
                print(e.toString());
                return true;
              },
                columnWidthMode: ColumnWidthMode.fill,
                rowHeight: 70.0,
                headerRowHeight: 60.0,
                source:  new TtableDataSource(selectedTtable: selectedTtable),
                // source: new TtableDataSource(selectedTtable: selectedTtable),
                columns: <GridColumn>[
                  GridColumn(columnName: 'Пара', label: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Пара',
                      )
                  )),
                  GridColumn(columnName: 'Предмет', label: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Предмет',
                      )
                  )),
                  GridColumn(columnName: 'Преподаватель', label: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Преподаватель',
                      )
                  )),
                  GridColumn(columnName: 'Кабинет', label: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Кабинет',
                      )
                  )),
                ]
            ),
          )
        ),
      ),

    //     ..onTap = () {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => const TeacherLogin()));
    //   print("Sign Up click");
    // }

      bottomNavigationBar: FluidNavBar(

        icons: [
          FluidNavBarIcon(
              svgPath: "assets/icon/PN.svg",
              backgroundColor: Colors.pink,
              extras: {"label": "PN"}
            ),
          FluidNavBarIcon(
              svgPath: "assets/icon/VT.svg",
              backgroundColor: Colors.pink,
              extras: {"label": "vt"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/SR.svg",
              backgroundColor: Colors.pink,
              extras: {"label": "sr"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/4T.svg",
              backgroundColor: Colors.pink,
              extras: {"label": "4t"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/PT.svg",
              backgroundColor: Colors.pink,
              extras: {"label": "pt"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/SB.svg",
              backgroundColor: Colors.pink,
              extras: {"label": "sb"}
              ),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            barBackgroundColor: Colors.blue,
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.white60),
        scaleFactor: 1.5,
        defaultIndex: 0,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item
        ),
      ),
    );
  }
}

class TtableDataSource extends DataGridSource {
  TtableDataSource({required List<TTable> selectedTtable}) {
    _ttables = selectedTtable
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'Пара', value: e.lesson.lessonNumber),
      DataGridCell<String>(columnName: 'Предмет', value: e.disciplineGroupTeacher.discipline.disciplineName),
      DataGridCell<String>(
          columnName: 'Преподаватель', value: e.disciplineGroupTeacher.teacher.name),
      DataGridCell<String>(columnName: 'Кабинет', value: e.office.officeNumber),
    ]))
        .toList();
  }

  List<DataGridRow>  _ttables = [];

  @override
  List<DataGridRow> get rows =>  _ttables;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: (dataGridCell.columnName == 'Пара' || dataGridCell.columnName == 'Предмет')
                ? Alignment.centerLeft
                : Alignment.centerRight,
            padding: EdgeInsets.all(5.0),
            child: Text(dataGridCell.value.toString()),
          );
        }).toList());
  }
}