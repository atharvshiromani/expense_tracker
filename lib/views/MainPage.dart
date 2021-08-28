import 'package:expense_tracker/classes/expcategory.dart';
import 'package:expense_tracker/views/LoginPage.dart';
import 'package:expense_tracker/views/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:expense_tracker/views/AddTx.dart';
import 'package:expense_tracker/views/ListTx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final authenticator = FirebaseAuth.instance;
final auth = Authenticator(authenticator);

class MainPage extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    //print(chartData);

    Expense newexp = new Expense('', '', DateTime.now(), 0);
    ExpCategory newexpcat = new ExpCategory('', 0);
    return Scaffold(
      backgroundColor: Color(0xFF0d1b2a),
      body: Container(
        margin: EdgeInsets.all(50.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                      TextButton(
                        key: ValueKey('signout'),
                        child: Text('SignOut'),
                        onPressed: () async {
                          auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
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
            flex: 2,
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
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Row(children: [
                          Container(
                            child: Text(
                              'Daily Transactions',
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          FloatingActionButton(
                              key: ValueKey('addtxbutton'),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AddTx(
                                          key: Key('addtxwidget'),
                                          expense: newexp,
                                          expcat: newexpcat,
                                        ));
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40.0,
                              )),
                        ]),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Expense',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28.0,
                              )),
                          TotalExpense(),
                        ],
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Category'),
                          Text('Date'),
                          Text('Expense'),
                          Text('Amount'),
                        ],
                      ),
                    ),
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
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: auth.fromDB(context, 'Transactions'),
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
            tooltipBehavior: _tooltipBehavior,
            primaryXAxis: NumericAxis(),
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
  List<ExpCategory> chartData = <ExpCategory>[];
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<void>(
      stream: auth.fromDB(context, 'Category'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget widget = Container();
        if (snapshot.hasData) {
          for (int index = 0; index < snapshot.data.docs.length; index++) {
            DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                snapshot.data.docs[index];

            // here we are storing the data into a list which is used for chart’s data source
            chartData.add(ExpCategory.fromMap(
                documentSnapshot.data() as Map<String, dynamic>));
          }

          Map map = {};
          for (var i = 0; i < chartData.length; i++) {
            ExpCategory exp = chartData[i];
            if (map.containsKey(exp.category)) {
              map.update(exp.category, (value) => value + exp.expense);
            }
            map.putIfAbsent(exp.category, () => exp.expense);
          }
          print(map);
          List<ExpCategory> list = [];
          map.forEach((k, v) => list.add(ExpCategory(k, v)));

          widget = Container(
              child: SfCircularChart(
            tooltipBehavior: _tooltipBehavior,
            legend: Legend(
              isVisible: true,
            ),
            series: <CircularSeries<ExpCategory, dynamic>>[
              PieSeries<ExpCategory, String>(
                  enableSmartLabels: true,
                  dataSource: list,
                  xValueMapper: (ExpCategory data, _) => data.category,
                  yValueMapper: (ExpCategory data, _) => data.expense,
                  dataLabelMapper: (ExpCategory data, _) => data.category,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside))
            ],
          ));
        }
        return widget;
      },
    ));
  }
}

class TotalExpense extends StatefulWidget {
  const TotalExpense({Key? key}) : super(key: key);

  @override
  _TotalExpenseState createState() => _TotalExpenseState();
}

class _TotalExpenseState extends State<TotalExpense> {
  int chartData = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: StreamBuilder<QuerySnapshot>(
          stream: auth.fromDB(context, 'Category'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget widget = Container();
            if (snapshot.hasData) {
              for (int index = 0; index < snapshot.data.docs.length; index++) {
                int documentSnapshot = snapshot.data.docs[index]['Amount'];

                // here we are storing the data into a list which is used for chart’s data source
                chartData += documentSnapshot;
              }

              widget = Container(
                  child: Text('\$' + chartData.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                      )));
            }
            return widget;
          },
        ));
  }
}
