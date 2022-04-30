
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:sands/model/Ttable.dart';
import 'package:sands/model/teacher.dart' as tch;
import 'package:sands/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:sands/pages/menu_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../widgets/myappbar.dart';
import '../widgets/mydraver.dart';


class TtableFromTeacher extends StatefulWidget {
  const TtableFromTeacher({Key? key, required this.teacher}) : super(key: key);
  final tch.Teacher? teacher;
  @override
  _MainTeacherState createState() => _MainTeacherState(teacher);
}



class _MainTeacherState extends State<TtableFromTeacher> with SingleTickerProviderStateMixin {
  int selectBtn = 0;
  late List<TTable> ponedelnik;
  late List<TTable> vtornik;
  late List<TTable> sreda;
  late List<TTable> tchetverg;
  late List<TTable> piatnica;
  late List<TTable> subbota;
  late int selectedTtable;
  late List<List<TTable>> allTtables = [];
  final tch.Teacher? teacher;


   void toggle() {
   
  }

  _MainTeacherState(this.teacher);
  late String? token;
  void getToken(){
    FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      print(token);
    });
  }
  void saveToken() async{
    
    var client = http.Client();
    try {
      var response = await client.post(
      Uri.https('abdul-arabp.site', '/restapi/public/api/push'),
      body: {'idteacher': teacher!.idteacher.toString(), 'token': token, 'api_token': 'a23ew9dosTeacher21apksfjnsdjlk'});
      var a = response.body;
    } finally {
      client.close();
    }
  }

  Future getGroupsData() async {
    var responce1 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforteacher/${teacher?.idteacher}/1'));
    var responce2 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforteacher/${teacher?.idteacher}/2'));
    var responce3 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforteacher/${teacher?.idteacher}/3'));
    var responce4 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforteacher/${teacher?.idteacher}/4'));
    var responce5 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforteacher/${teacher?.idteacher}/5'));
    var responce6 = await http.get(Uri.https('abdul-arabp.site',
        '/restapi/public/api/ttable/getforteacher/${teacher?.idteacher}/6'));
    setState(() {
      ponedelnik = tTableFromJson(responce1.body);
      vtornik = tTableFromJson(responce2.body);
      sreda = tTableFromJson(responce3.body);
      tchetverg = tTableFromJson(responce4.body);
      piatnica = tTableFromJson(responce5.body);
      subbota = tTableFromJson(responce6.body);
      allTtables = [ponedelnik, vtornik, sreda, tchetverg, piatnica, subbota];
      saveToken();
    });
  }
  void initState() {

    allTtables = [];
    ponedelnik = [];
    if(DateTime.now().weekday-1 == 6){
      selectedTtable = 0;
    }
    else{
      selectedTtable = DateTime.now().weekday-1;
    }
    getGroupsData();
    getToken();
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
    });
  }

  // ttable/getforgroup/{id}/{weekday}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(teacher: teacher),
        // drawer: MenuPage(teacher: teacher) ,
          backgroundColor: Theme.of(context).primaryColorDark,
            appBar: MyAppBar(toggle: toggle, title: "Расписание",),
            body: Container(
              child: Center (
                child: allTtables.isEmpty ? CircularProgressIndicator() : AnimatedSwitcher(
                  switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                    child: SfDataGrid(
                    allowSwiping: false,
                  
                    columnWidthMode: ColumnWidthMode.fill,
                    rowHeight: 70.0,
                    headerRowHeight: 60.0,
                    source: new TtableDataSource(selectedTtable: allTtables[selectedTtable]),
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
                      GridColumn(columnName: 'Группа', label: Container(
                          padding: EdgeInsets.all(5.0),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Группа',
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
            iconUnselectedForegroundColor: Theme.of(context).textTheme.displaySmall?.color),
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
          columnName: 'Группа', value: e.disciplineGroupTeacher.group.groupName),
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
