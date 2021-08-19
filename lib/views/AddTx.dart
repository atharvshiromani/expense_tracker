import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';

class AddTx extends StatelessWidget {
  Expense expense;
  AddTx({key, required this.expense}) : super(key: key);

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    TextEditingController _controller1 = new TextEditingController();
    //TextEditingController _controller2 = new TextEditingController();
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
                  Text('Enter Expense:'),
                  TextField(controller: _controller1),
                  Text('Enter Date:'),
                  TextButton(
                      onPressed: () async {
                        expense.category = _controller.text;
                        int amt = int.parse(_controller1.text);
                        expense.expense = amt;
                        expense.date = DateTime.now();
                        print('category:${expense.category}');
                        print('exp:${expense.expense}');
                        print(' Date:${expense.date}');

                        await db.collection('Transactions').add({
                          'Category': expense.category,
                          'Amount': expense.expense,
                          'Date': expense.date,
                        });
                      },
                      child: Text('Add Expense')),
                ],
              )),
        ]),
      ),
    ]));
  }
}
