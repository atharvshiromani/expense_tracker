import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:expense_tracker/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Verifying Login Page functionality by entering correct email, password and then login in',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final emailTextField = find.byKey(Key('email'));
      final passTextField = find.byKey(Key('password'));
      final loginButton = find.byKey(Key('login'));
      final addtxbutton = find.byKey(Key('addtxbutton'));
      final addtxwidget = find.byKey(Key('addtxwidget'));

      await tester.tap(emailTextField);
      await tester.enterText(emailTextField, 'atharv@cmail.com');

      print('1');

      expect(find.text('atharv@cmail.com'), findsOneWidget);
      print('2');

      await tester.tap(passTextField);
      print('3');
      await tester.enterText(passTextField, 'atharv');
      print('4');

      expect(find.text('atharv'), findsOneWidget);
      print('5');

      await tester.tap(loginButton);
      print('6');

      tester.pumpAndSettle();
      print('7');

      await tester.tap(addtxbutton);
      print('8');
      tester.pumpAndSettle();
      print('9');

      expect(find.text('atharv@cmail.com'), findsOneWidget);
      print('10');
    },
  );
}
