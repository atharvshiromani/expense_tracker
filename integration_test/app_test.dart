import 'package:expense_tracker/views/LoginPage.dart';
import 'package:expense_tracker/views/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:expense_tracker/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        "full-app-testing, from login to adding a new transaction and then finally signing out",
        (tester) async {
      // running the app.
      app.main();

      await tester.pumpAndSettle();
      //finding out the location of each widget
      final emailTextField = find.byType(TextFormField).first;
      final passTextField = find.byType(TextFormField).last;
      final Finder loginButton = find.byKey(ValueKey('loginButton'));

      //entering the email id
      await tester.enterText(emailTextField, 'atharv@cmail.com');
      //matching it against the value entered.
      //Note: the functionality of the expect method is match the value returned with a matcher
      expect(find.text('atharv@cmail.com'), findsOneWidget);

      //Similarly automating password textfield.

      await tester.enterText(passTextField, 'atharv');
      expect(find.text('atharv'), findsOneWidget);
      await tester.pumpAndSettle();

      //tapping the login button
      await tester.tap(loginButton);
      //verify(mockObserver.didPush(any, any));
      await tester.pumpAndSettle((Duration(seconds: 3)));

      //if login details are correct, the application moves to the user's main page.
      expect(find.byType(MainPage), findsOneWidget);

      // Testing adding Transaction feature.
      final Finder addtxButton = find.byKey(ValueKey('addtxbutton'));
      // tapping the add button
      await tester.tap(addtxButton);
      await tester.pumpAndSettle((Duration(seconds: 2)));

      // if the button is tapped, a dialog box with form is opened.
      expect(find.byKey(ValueKey('addtxdialog')), findsOneWidget);

      //finding and entering each feild of the form

      final Finder expense = find.byKey(ValueKey('expense'));
      final Finder category = find.byKey(ValueKey('category'));
      final Finder amount = find.byKey(ValueKey('amount'));
      final Finder addexpbutton = find.byKey(ValueKey('addexpbutton'));

      await tester.enterText(category, 'food');
      await tester.enterText(expense, 'grocery');
      await tester.enterText(amount, '150');

      await tester.pumpAndSettle();

      //tapping the add expense button to save the data in the database and if successful, the chart are updated and and the expense shows up in the list view

      await tester.tap(addexpbutton);
      await tester.pumpAndSettle((Duration(seconds: 2)));
      expect(find.byType(MainPage), findsOneWidget);

      //finding the signout button and signing out
      final Finder signoutbutton = find.byKey(ValueKey('signout'));

      await tester.tap(signoutbutton);
      await tester.pumpAndSettle((Duration(seconds: 2)));

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
