import 'package:expense_tracker/views/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '', _password = '';
  final authenticator = FirebaseAuth.instance;

  // TextEditingController _controller = new TextEditingController();
  // TextEditingController _controller1 = new TextEditingController();
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
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Enter Email Address'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              Text('Password:'),
              TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter Password'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  child: Text(
                    'Login',
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0d1b2a))),
                  onPressed: () async {
                    authenticator.signInWithEmailAndPassword(
                        email: _email, password: _password);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  }),
              SizedBox(height: 10.0),
              Container(child: Text('New user ?SignUp')),
              SizedBox(height: 10.0),
              ElevatedButton(
                  child: Text(
                    'SignUp',
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0d1b2a))),
                  onPressed: () {
                    authenticator.createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    //_SignUpState().AuthenticationHelper().signUp()
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
