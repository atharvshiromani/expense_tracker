import 'package:expense_tracker/views/authentication.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ListTx extends StatefulWidget {
  @override
  _ListTxState createState() => _ListTxState();
}

class _ListTxState extends State<ListTx> {
  final db = FirebaseFirestore.instance;
  final auth = Authenticator();

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Container expIcon(String category) {
    return Container(
        child: (category == 'food')
            ? Icon(Icons.fastfood)
            : (category == 'shopping')
                ? Icon(Icons.shopping_cart)
                : (category == 'automobile')
                    ? Icon(Icons.directions_car)
                    : Icon(Icons.account_balance));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: auth.fromDB(context, 'Transactions'),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Expenses to Show! Add One to get going :)'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      Column(
                        children: [
                          expIcon(document['Category'].toString()),
                        ],
                      ),
                      Text(dateFormat
                          .format(document['Date'].toDate())
                          .toString()),
                      Text(document['Expense'].toString()),
                      Text('\$' + document['Amount'].toString()),
                    ])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
