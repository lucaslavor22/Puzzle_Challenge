// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:puzzle_game/main.dart';

void main() {
  testWidgets('Puzzle game smoke test', (WidgetTester tester) async {
    // Construa o app e dispare um frame.
    await tester.pumpWidget(PuzzleGame());

    // Verifique se algum elemento específico está presente.
    expect(find.text('1'), findsOneWidget);

    // Simule uma interação.
    await tester.tap(find.text('1'));
    await tester.pump();

    // Verifique o resultado da interação.
    expect(find.text('1'), findsOneWidget);
  });
}

