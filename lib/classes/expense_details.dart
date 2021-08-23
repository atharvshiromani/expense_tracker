import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String category;
  String expName;
  DateTime day;
  int expense;

  Expense(this.category, this.expName, this.day, this.expense);
  Map<String, dynamic> toJson() => {
        'Category': category,
        'Expense': expName,
        'Amount': expense,
        'Date': day,
      };

  Expense.fromMap(Map<String, dynamic> parseJson)
      : category = parseJson['Category'].toString(),
        expName = parseJson['Expense'],
        expense = parseJson['Amount'],
        day = (parseJson['Date'] as Timestamp).toDate();
}
