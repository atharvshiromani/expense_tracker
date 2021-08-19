import 'package:flutter/material.dart';
import 'package:expense_tracker/views/MainPage.dart';

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
