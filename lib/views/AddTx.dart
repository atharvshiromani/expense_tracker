import 'package:expense_tracker/views/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final authenticator = Authenticator();

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    TextEditingController _controller1 = new TextEditingController();
    TextEditingController _controller2 = new TextEditingController();
    return SimpleDialog(
        key: ValueKey('addtxdialog'),
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
                      TextFormField(
                          key: ValueKey('category'),
                          controller: _controller,
                          autofocus: true),
                      SizedBox(height: 10),
                      Text('Enter Expense Name:'),
                      TextField(
                          key: ValueKey('expense'), controller: _controller2),
                      SizedBox(height: 10),
                      Text('Enter Amount:'),
                      TextFormField(
                          key: ValueKey('amount'), controller: _controller1),
                      SizedBox(height: 10),
                      Text('Enter Date:'),
                      DatePicker(),
                      TextButton(
                          key: ValueKey('addexpbutton'),
                          onPressed: () async {
                            int amt = int.parse(_controller1.text);

                            await authenticator.addTxtoDB(
                                _controller.text,
                                _controller2.text,
                                amt,
                                _DatePickerState.selectedDate);

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
