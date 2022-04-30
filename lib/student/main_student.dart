import 'dart:convert';
import 'dart:ui';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:sands/model/Ttable.dart';
import 'package:sands/model/group.dart' as gr;
// import 'package:sands/widgets/custom_paint.dart';
import 'package:sands/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:sands/widgets/myappbar.dart';
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
  late List<List<TTable>> allTtables = [];
  late int selectedTtable;

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
      allTtables = [ponedelnik, vtornik, sreda, tchetverg, piatnica, subbota];
    });
  }
  void initState() {
    allTtables = [];
    ponedelnik = [];
    // selectedTtable = 0;
    if(DateTime.now().weekday-1 == 6){
      selectedTtable = 0;
    }
    else{
      selectedTtable = DateTime.now().weekday-1;
    }
    getGroupsData();
    super.initState();
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index){
        case 0:
          selectedTtable = 0;
          break;
        case 1:
          selectedTtable = 1;
          break;
        case 2:
          selectedTtable = 2;
          break;
        case 3:
          selectedTtable = 3;
          break;
        case 4:
          selectedTtable = 4;
          break;
        case 5:
          selectedTtable = 5;
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
  void togle(){}
  // ttable/getforgroup/{id}/{weekday}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: MyAppBar(title: "Расписание ${group?.groupName}", toggle: togle,),
      body: Container(
        child: Center (
          child: allTtables.isEmpty ? CircularProgressIndicator(

          ) : AnimatedSwitcher(switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            child: SfDataGrid(
              
                columnWidthMode: ColumnWidthMode.fill,
                rowHeight: 70.0,
                headerRowHeight: 60.0,
                source:  new TtableDataSource(selectedTtable: allTtables[selectedTtable]),
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


      bottomNavigationBar: FluidNavBar(

        icons: [
          FluidNavBarIcon(
              svgPath: "assets/icon/PN.svg",
              backgroundColor: Theme.of(context).primaryColorLight,
              extras: {"label": "PN"}
            ),
          FluidNavBarIcon(
              svgPath: "assets/icon/VT.svg",
              backgroundColor: Theme.of(context).primaryColorLight,
              extras: {"label": "vt"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/SR.svg",
              backgroundColor: Theme.of(context).primaryColorLight,
              extras: {"label": "sr"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/4T.svg",
              backgroundColor: Theme.of(context).primaryColorLight,
              extras: {"label": "4t"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/PT.svg",
              backgroundColor: Theme.of(context).primaryColorLight,
              extras: {"label": "pt"}
              ),
          FluidNavBarIcon(
              svgPath: "assets/icon/SB.svg",
              backgroundColor: Theme.of(context).primaryColorLight,
              extras: {"label": "sb"}
              ),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            barBackgroundColor: Theme.of(context).primaryColor,
            iconSelectedForegroundColor: Theme.of(context).textTheme.bodyMedium?.color,
            iconUnselectedForegroundColor: Theme.of(context).textTheme.displaySmall?.color
            ),
        scaleFactor: 1.5,
        defaultIndex: selectedTtable,
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
    ])).toList();
  }

  List<DataGridRow>  _ttables = [];

  @override
  List<DataGridRow> get rows =>  _ttables;

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