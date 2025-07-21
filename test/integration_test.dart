import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:code_task/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Full app loads and shows user profile", (tester) async {
    app.main(); // Call your app's entry
    await tester.pumpAndSettle();

    expect(find.text('User Profile'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.textContaining('@'), findsOneWidget); // Check email presence
  });
}
