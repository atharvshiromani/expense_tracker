import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(title: 'Expensify', home: LoginPage()));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Expensify'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 500.00,
          width: 500.00,
          child: Column(
            children: [
              Container(
                child: Text('Login Details'),
              ),
              Container(
                child: Text('Email:'),
              ),
              Container(
                child: Text('Password:'),
              ),
              ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  List<String> res = [];
  AlertDialog AddTx() {
    return AlertDialog(
        content: Stack(children: <Widget>[
      Positioned(
        right: -40.0,
        top: -40.0,
        child: InkResponse(
          onTap: () {},
          child: CircleAvatar(
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      Form(
        child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Enter Category:'),
                  TextFormField(),
                  Text('Enter Expense:'),
                  TextFormField(),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
        ]),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
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
                                      builder: (context) => AddTx());
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

class ListTx extends StatelessWidget {
  List<Expense> tx = [
    Expense('food', DateTime.now(), 300),
    Expense('shopping', DateTime.now(), 100),
    Expense('automobile', DateTime.now(), 100),
  ];

  Container expIcon(String category) {
    return Container(
        child: (category == 'food')
            ? Icon(Icons.fastfood)
            : (category == 'shopping')
                ? Icon(Icons.shopping_cart)
                : Icon(Icons.directions_car));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                    Column(
                      children: [
                        expIcon(tx[index].category),
                        Text(DateFormat('dd/MM/yyyy')
                            .format(tx[index].date)
                            .toString()),
                      ],
                    ),
                    Text('\$' + tx[index].expense.toString()),
                  ]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: tx.length));
  }
}
