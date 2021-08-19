import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:intl/intl.dart';

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
