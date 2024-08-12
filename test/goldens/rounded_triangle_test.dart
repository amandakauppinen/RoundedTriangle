import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rounded_triangle/rounded_triangle.dart';

/// Tests the widget's visibility, run:
///     flutter test --update-goldens
/// to generate 'main.png' for comparison when running the test.
/// Must be run again if the code has been updated.

void main() {
  testWidgets('RoundedTriangle is visible', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RoundedTriangle(
            borderColor: Colors.black,
          ),
        ),
      ),
    );

    final finder = find.byType(RoundedTriangle);

    await expectLater(finder, matchesGoldenFile('main.png'));
  });
}
