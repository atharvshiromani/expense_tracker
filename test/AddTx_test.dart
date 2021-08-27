import 'package:expense_tracker/views/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

import 'package:expense_tracker/main.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  app.main();
  group('Unit Test', () {
    test(
        'Testing the AddTx functionality to see if transactions are added to the database',
        () {
      final signintest = Authenticator().signIn('atharv@cmail.com', 'atharv');

      expect(signintest, 'Successful');
    });
  });
}
