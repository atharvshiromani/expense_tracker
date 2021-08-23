import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:expense_tracker/views/MainPage.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/classes/expcategory.dart';

class AddTx extends StatelessWidget {
  Expense expense;
  ExpCategory expcat;
  AddTx({key, required this.expense, required this.expcat}) : super(key: key);

  final db = FirebaseFirestore.instance;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

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
                  DatePicker(),
                  TextButton(
                      onPressed: () async {
                        expense.category = _controller.text;
                        expcat.category = _controller.text;
                        expense.expName = _controller2.text;
                        int amt = int.parse(_controller1.text);
                        expense.expense = amt;
                        expcat.expense = amt;
                        expense.day = _DatePickerState.selectedDate;

                        await db
                            .collection('Transactions')
                            .add(expense.toJson());

                        await db.collection('Category').add(expcat.toJson());

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

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  static DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => _selectDate(context),
      child: Text(
        'Select date',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
