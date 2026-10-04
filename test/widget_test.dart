import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fut_stats/main.dart';

void main() {
  testWidgets('navega entre as abas principais', (WidgetTester tester) async {
    await tester.pumpWidget(const BrasileiraoApp());

    expect(find.text('Jogos de Hoje'), findsOneWidget);
    expect(find.text('Flamengo'), findsOneWidget);

    await tester.tap(find.text('Tabela'));
    await tester.pumpAndSettle();
    expect(find.text('Classificação'), findsOneWidget);

    await tester.tap(find.text('Bolão'));
    await tester.pumpAndSettle();
    expect(find.text('Meus Palpites'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.keyboard_arrow_up).first);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
