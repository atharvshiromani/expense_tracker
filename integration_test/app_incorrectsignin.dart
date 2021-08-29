import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:expense_tracker/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        "checking the login functionality with the incorrect combination of email/password",
        (tester) async {
      // running the app.
      app.main();

      await tester.pumpAndSettle();
      //finding out the location of each widget
      final emailTextField = find.byType(TextFormField).first;
      final passTextField = find.byType(TextFormField).last;
      final Finder loginButton = find.byKey(ValueKey('loginButton'));

      //entering the email id
      await tester.enterText(emailTextField, 'atharv@testcmail.com');
      //matching it against the value entered.
      //Note: the functionality of the expect method is match the value returned with a matcher
      expect(find.text('atharv@testcmail.com'), findsOneWidget);

      //Similarly automating password textfield.

      await tester.enterText(passTextField, 'atharv1');
      expect(find.text('atharv1'), findsOneWidget);
      await tester.pumpAndSettle();

      //tapping the login button
      await tester.tap(loginButton);
      //verify(mockObserver.didPush(any, any));
      await tester.pumpAndSettle((Duration(seconds: 3)));

      //if login details are correct, the application moves to the user's main page.
      expect(find.byKey(ValueKey('invalidlogin')), findsOneWidget);
    });
  });
}
