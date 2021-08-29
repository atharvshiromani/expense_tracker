import 'package:expense_tracker/views/MainPage.dart';
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
      final Finder signUpButton = find.byKey(ValueKey('signup'));

      //entering the email id
      await tester.enterText(emailTextField, 'atharv@testcmail.com');
      //matching it against the value entered.

      expect(find.text('atharv@testcmail.com'), findsOneWidget);

      //Similarly automating password textfield.

      await tester.enterText(passTextField, 'atharv');
      expect(find.text('atharv'), findsOneWidget);
      await tester.pumpAndSettle();

      //tapping the signup button
      await tester.tap(signUpButton);

      await tester.pumpAndSettle((Duration(seconds: 2)));

      //if signup is sucessfull, the application display a dialog box saying Signed Up Successfully.
      expect(find.byKey(ValueKey('signedup')), findsOneWidget);

      await tester.pumpAndSettle((Duration(seconds: 3)));
      expect(find.byType(MainPage), findsOneWidget);
    });
  });
}
