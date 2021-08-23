import 'package:expense_tracker/classes/expcategory.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:expense_tracker/views/AddTx.dart';
import 'package:expense_tracker/views/ListTx.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class MainPage extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  // final db = FirebaseFirestore.instance;
  //
  // List<Expense> chartData = [];
  //
  // Future<List<Expense>> _getList() async {
  //   final querySnapshot =
  //       await FirebaseFirestore.instance.collection('Transactions').get();
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
  //   final lsData = docs.map((doc) => Expense.fromJson(doc.data())).toList();
  //
  //   return lsData;
  // }

  @override
  Widget build(BuildContext context) {
    //print(chartData);

    Expense newexp = new Expense('', '', DateTime.now(), 0);
    ExpCategory newexpcat = new ExpCategory('', 0);
    return Scaffold(
      backgroundColor: Color(0xFF0d1b2a),
      body: Container(
        margin: EdgeInsets.all(50.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xE0e0e1dd),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          radius: 50.0,
                          child: Text('AS'),
                          backgroundColor: Color(0xFF0d1b2a),
                        ),
                      ),
                      Text('Monthly Overview'),
                      Expanded(
                        flex: 1,
                        child: Chart(),
                      ),
                      Text('Expenses by Category'),
                      Expanded(child: Chart1())
                    ])),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xE0e0e1dd),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(children: [
                          Container(
                            child: Text(
                              'Daily Transactions',
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60.0),
                            child: FloatingActionButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AddTx(
                                            expense: newexp,
                                            expcat: newexpcat,
                                          ));
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 40.0,
                                )),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total Expense'),
                        Text('120'),
                      ],
                    )),
                    ListTx(),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final CollectionReference fireData =
      FirebaseFirestore.instance.collection('Transactions');

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<void>(
      stream: fireData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget widget = Container();
        if (snapshot.hasData) {
          List<Expense> chartData = <Expense>[];
          for (int index = 0; index < snapshot.data.docs.length; index++) {
            DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                snapshot.data.docs[index];

            // here we are storing the data into a list which is used for chart’s data source
            chartData.add(Expense.fromMap(
                documentSnapshot.data() as Map<String, dynamic>));
          }

          widget = Container(
              child: SfCartesianChart(
            series: <ChartSeries<Expense, dynamic>>[
              ColumnSeries<Expense, int>(
                  dataSource: chartData,
                  xValueMapper: (Expense data, _) => data.day.day,
                  yValueMapper: (Expense data, _) => data.expense)
            ],
          ));
        }
        return widget;
      },
    ));
  }
}

class Chart1 extends StatefulWidget {
  const Chart1({Key? key}) : super(key: key);

  @override
  _Chart1State createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  final CollectionReference fireData =
      FirebaseFirestore.instance.collection('Category');

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<void>(
      stream: fireData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget widget = Container();
        if (snapshot.hasData) {
          List<ExpCategory> chartData = <ExpCategory>[];
          for (int index = 0; index < snapshot.data.docs.length; index++) {
            DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                snapshot.data.docs[index];

            // here we are storing the data into a list which is used for chart’s data source
            chartData.add(ExpCategory.fromMap(
                documentSnapshot.data() as Map<String, dynamic>));
          }

          widget = Container(
              child: SfCircularChart(
            series: <CircularSeries<ExpCategory, dynamic>>[
              PieSeries<ExpCategory, String>(
                  dataSource: chartData,
                  xValueMapper: (ExpCategory data, _) => data.category,
                  yValueMapper: (ExpCategory data, _) => data.expense)
            ],
          ));
        }
        return widget;
      },
    ));
  }
}
