import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

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
                    color: Color(0xFFe0e1dd),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 50.0,
                        child: Text('AS'),
                        backgroundColor: Color(0xFFe0e1dd),
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
          Spacer(),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFe0e1dd),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF415a77),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      Container(
                        child: Text('Daily Transactions'),
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      FloatingActionButton(
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
                    ]),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Total Expense'),
                      Text('Total Income'),
                      Text('Net'),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AddTx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(children: <Widget>[
      Positioned(
        right: -40.0,
        top: -40.0,
        child: InkResponse(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      Form(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
        ]),
      ),
    ]));
  }
}
