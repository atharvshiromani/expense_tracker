import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Verifying Login Page functionality by entering correct email, password and then login in',
    (WidgetTester tester) async {
      final addtxbutton = find.byKey(Key('addtxbutton'));
      print('6');
      final addtxwidget = find.byKey(Key('addtxwidget'));

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
