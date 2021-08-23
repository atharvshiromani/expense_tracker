import 'package:expense_tracker/authenticationservice/auth_service.dart';
import 'package:expense_tracker/views/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
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
              TextField(controller: _controller, autofocus: true),
              Container(
                child: Text('Password:'),
              ),
              TextField(controller: _controller1),
              ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  }),

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainPage()),

              Container(child: Text('New user ?SignUp')),
              ElevatedButton(
                  child: Text('SignUp'),
                  onPressed: () {
                    //_SignUpState().AuthenticationHelper().signUp()
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => MainPage()),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     AuthenticationHelper().signUp(email, password)
//         .then((result) {
//       if (result == null) {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => LoginPage()));
//       } else {
//         Scaffold.of(context).showSnackBar(SnackBar(
//           content: Text(
//             result,
//             style: TextStyle(fontSize: 16),
//           ),
//         ));
//       }
//     });
//   }
// }
