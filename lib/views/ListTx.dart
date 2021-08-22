import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/classes/expense_details.dart';
import 'package:intl/intl.dart';

class ListTx extends StatelessWidget {
  final db = FirebaseFirestore.instance;

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
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Transactions').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
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

                          // Text(DateFormat('dd/MM/yyyy')
                          //     .format(document['Date'])
                          //     .toString()),
                        ],
                      ),
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
