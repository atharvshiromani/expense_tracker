import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/views/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/views/authentication.dart';

final authenticator = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;
final auth = Authenticator(authenticator, db);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0d1b2a),
      appBar: AppBar(
        title: Column(children: [
          Text('EXPENSIFY'),
          Text('A Minimal Expense Tracker', style: TextStyle(fontSize: 12.0)),
        ]),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Color(0xE0e0e1dd),
              borderRadius: BorderRadius.circular(10)),
          height: 500.00,
          width: 500.00,
          child: Column(
            children: [
              Container(
                child: Text('Login Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 20.0),
              Text('Email:'),
              TextFormField(
                key: ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Enter Email Address'),
                controller: _email,
              ),
              SizedBox(height: 10.0),
              Text('Password:'),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter Password'),
                controller: _password,
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  key: ValueKey('loginButton'),
                  child: Text(
                    'Login',
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0d1b2a))),
                  onPressed: () async {
                    final String res =
                        await auth.signIn(_email.text, _password.text);
                    if (res == 'Signed In') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              key: ValueKey('invalidlogin'),
                              title: Text('Sign In Failed!'),
                              content: Text(res),
                            );
                          });
                    }
                  }),
              SizedBox(height: 10.0),
              Container(child: Text('New user ?SignUp')),
              SizedBox(height: 10.0),
              ElevatedButton(
                  key: ValueKey('signup'),
                  child: Text(
                    'SignUp',
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0d1b2a))),
                  onPressed: () async {
                    final String res =
                        await auth.signUp(_email.text, _password.text);

                    if (res == 'Signed Up') {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              key: ValueKey('signedup'),
                              title: Text('Signed Up Successfully'),
                              content: Text('Login to continue'),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Signed Up Successfully'),
                              content: Text(res),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
