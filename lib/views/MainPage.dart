import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/views/AddTx.dart';
import 'package:expense_tracker/views/ListTx.dart';

class MainPage extends StatelessWidget {
  List<String> res = [];

  @override
  Widget build(BuildContext context) {
    Expense newexp = new Expense('food,shopping,autmobile', DateTime.now(), 0);
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
                    Container(
                        child: Column(
                      children: [
                        Text('Monthly Overview'),
                        Text('Expenses By Category'),
                      ],
                    ))
                  ],
                )),
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
