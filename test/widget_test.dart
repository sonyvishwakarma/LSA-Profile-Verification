import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habot_lsa_verification/screens/lsa_profile_verification_screen.dart';

void main() {
  testWidgets('LSA Verification Screen loads properly', (WidgetTester tester) async {
    // Render the screen wrapped in a MaterialApp
    await tester.pumpWidget(
      const MaterialApp(
        home: LsaProfileVerificationScreen(),
      ),
    );

    // Verify key UI elements exist
    expect(find.text('SUBMIT VERIFICATION'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
  });

  testWidgets('Fail-closed security triggers on empty submission', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LsaProfileVerificationScreen(),
      ),
    );

    // Tap submit button with empty fields
    await tester.tap(find.text('SUBMIT VERIFICATION'));
    await tester.pump();

    // Verify fail-closed error state triggers
    expect(find.textContaining('FAIL-CLOSED'), findsOneWidget);
  });
}