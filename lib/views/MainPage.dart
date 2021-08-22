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
  final db = FirebaseFirestore.instance;

  List<Expense> chartData = [];

  Future<List<Expense>> _getList() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Transactions').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    final lsData = docs.map((doc) => Expense.fromJson(doc.data())).toList();

    return lsData;
  }

  foo() async {
    final Future<List<Expense>> futureList = _getList();
    chartData = await futureList;
  }

  @override
  Widget build(BuildContext context) {
    foo();
    print(chartData);

    Expense newexp = new Expense('', '', 0, 0);
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
                      Container(
                        child: CircleAvatar(
                          radius: 50.0,
                          child: Text('AS'),
                          backgroundColor: Color(0xFF0d1b2a),
                        ),
                      ),
                      Text('Monthly Overview'),
                      Container(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Transactions')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Column(children: [
                                  Container(
                                      child: SfCartesianChart(
                                          primaryXAxis: NumericAxis(
                                              // X axis is hidden now
                                              isVisible: false),
                                          primaryYAxis: NumericAxis(
                                              // X axis is hidden now
                                              isVisible: false),
                                          margin: const EdgeInsets.all(2),
                                          series: <ChartSeries>[
                                        // Renders bar chart
                                        ColumnSeries<Expense, int>(
                                          dataSource: chartData,
                                          xValueMapper: (Expense exp, _) =>
                                              exp.expense,
                                          yValueMapper: (Expense exp, _) =>
                                              exp.day,
                                        )
                                      ])),
                                  Text('Expenses By Category'),
                                ]);
                              })),
                      Container(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Transactions')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Column(children: [
                                  Container(
                                      child: SfCircularChart(
                                          margin: const EdgeInsets.all(2),
                                          series: <CircularSeries>[
                                        // Renders bar chart
                                        DoughnutSeries<Expense, String>(
                                            dataSource: chartData,
                                            xValueMapper: (Expense exp, _) =>
                                                exp.category,
                                            yValueMapper: (Expense exp, _) =>
                                                exp.expense)
                                      ])),
                                ]);
                              }))
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Total Expense'),
                            Text('Total Income'),
                            Text('Net'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('120'),
                            Text('120'),
                            Text('0'),
                          ],
                        ),
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
