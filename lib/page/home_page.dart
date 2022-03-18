import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/data/model.dart';
import 'package:flutter_application_1/model/Ttable.dart';
import 'package:flutter_application_1/model/group.dart' as gr;
import 'package:flutter_application_1/widgets/custom_paint.dart';
import 'package:flutter_application_1/constants/color.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.group}) : super(key: key);
  final gr.Group? group;
  @override
  _HomePageState createState() => _HomePageState(group);
}



class _HomePageState extends State<HomePage> {
  int selectBtn = 0;
  late List<TTable> ponedelnik;
  late List<TTable> vtornik;
  late List<TTable> sreda;
  late List<TTable> tchetverg;
  late List<TTable> piatnica;
  late List<TTable> subbota;
  List<TTable> selectedTtable = [];
  late TtableDataSource _ttableDataSource;
  final gr.Group? group;
  _HomePageState(this.group);
  
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
      });
  }
  void initState() {
    super.initState();
    getGroupsData();
    selectedTtable;
  }
  // ttable/getforgroup/{id}/{weekday}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Расписание для группы ${group?.groupName}"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: SfDataGrid(
            columnWidthMode: ColumnWidthMode.auto,
            rowHeight: 70.0,
            headerRowHeight: 60.0,
            source: new TtableDataSource(selectedTtable: selectedTtable),
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
      ),
      bottomNavigationBar: navigationBar(),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight:
              Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() {
                selectBtn = i;
                switch (i){
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
                print(selectedTtable.length);
              }),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? selectColor : black,
              scale: 2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBtn[i].name,
              style: isActive ? bntText.copyWith(color: selectColor) : bntText,
            ),
          )
        ],
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