import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:expense_tracker/views/MainPage.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/classes/expcategory.dart';

class AddTx extends StatefulWidget {
  Expense expense;
  ExpCategory expcat;
  AddTx({key, required this.expense, required this.expcat}) : super(key: key);

  @override
  _AddTxState createState() => _AddTxState();
}

class _AddTxState extends State<AddTx> {
  final db = FirebaseFirestore.instance;
  final authenticator = FirebaseAuth.instance;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    TextEditingController _controller1 = new TextEditingController();
    TextEditingController _controller2 = new TextEditingController();
    return SimpleDialog(
        title: Center(child: new Text("Add a New Expense")),
        contentPadding: EdgeInsets.all(20.0),
        children: [
          Form(
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Enter Category:'),
                      TextField(controller: _controller, autofocus: true),
                      SizedBox(height: 10),
                      Text('Enter Expense Name:'),
                      TextField(controller: _controller2),
                      SizedBox(height: 10),
                      Text('Enter Amount:'),
                      TextField(controller: _controller1),
                      SizedBox(height: 10),
                      Text('Enter Date:'),
                      DatePicker(),
                      TextButton(
                          onPressed: () async {
                            widget.expense.category = _controller.text;
                            widget.expcat.category = _controller.text;
                            widget.expense.expName = _controller2.text;
                            int amt = int.parse(_controller1.text);
                            widget.expense.expense = amt;
                            widget.expcat.expense = amt;
                            widget.expense.day = _DatePickerState.selectedDate;
                            String uid = authenticator.currentUser!.uid;
                            await db
                                .collection('userTxdata')
                                .doc(uid)
                                .collection('Transactions')
                                .add(widget.expense.toJson());

                            await db
                                .collection('userTxdata')
                                .doc(uid)
                                .collection('Category')
                                .add(widget.expcat.toJson());

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                          },
                          child: Text('Add Expense')),
                    ],
                  )),
            ]),
          ),
        ]);
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
    return IconButton(
      onPressed: () => _selectDate(context),
      icon: Icon(
        Icons.calendar_today,
      ),
    );
  }
}
