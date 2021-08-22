import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:expense_tracker/views/MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AddTx extends StatelessWidget {
  Expense expense;
  AddTx({key, required this.expense}) : super(key: key);

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    TextEditingController _controller1 = new TextEditingController();
    TextEditingController _controller2 = new TextEditingController();
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
                  TextField(controller: _controller, autofocus: true),
                  Text('Enter Expense Name:'),
                  TextField(controller: _controller2),
                  Text('Enter Amount:'),
                  TextField(controller: _controller1),
                  Text('Enter Date:'),
                  TextButton(
                      onPressed: () async {
                        expense.category = _controller.text;
                        expense.expName = _controller2.text;
                        int amt = int.parse(_controller1.text);
                        expense.expense = amt;
                        expense.day = 19;

                        await db
                            .collection('Transactions')
                            .add(expense.toJson());

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      child: Text('Add Expense')),
                ],
              )),
        ]),
      ),
    ]));
  }
}
