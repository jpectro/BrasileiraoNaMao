import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brasileirao_na_mao/data/mock_data.dart';
import 'package:brasileirao_na_mao/main.dart';
import 'package:brasileirao_na_mao/models/jogo.dart';
import 'package:brasileirao_na_mao/models/time_tabela.dart';

void main() {
  testWidgets('navega entre as abas principais', (WidgetTester tester) async {
    await tester.pumpWidget(const BrasileiraoApp());
    await tester.pumpAndSettle();

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

  testWidgets('abre o detalhe da partida com lances e estatísticas', (WidgetTester tester) async {
    await tester.pumpWidget(const BrasileiraoApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Flamengo'));
    await tester.pumpAndSettle();

    expect(find.text('Rodada 29'), findsOneWidget);
    expect(find.text('Maracanã'), findsOneWidget);
    expect(find.text('Pedro'), findsOneWidget);

    await tester.tap(find.text('Estatísticas'));
    await tester.pumpAndSettle();
    expect(find.text('Posse de bola'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Jogos de Hoje'), findsOneWidget);
  });

  testWidgets('filtra jogos por status', (WidgetTester tester) async {
    await tester.pumpWidget(const BrasileiraoApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Próximos'));
    await tester.pumpAndSettle();
    expect(find.text('Corinthians'), findsOneWidget);
    expect(find.text('Flamengo'), findsNothing);
  });

  test('placar dos mocks bate com os gols dos eventos', () {
    final flaFlu = jogosMock.firstWhere((j) => j.timeCasa == 'Flamengo');
    expect(flaFlu.golsCasa, 2);
    expect(flaFlu.golsFora, 1);

    // gol contra do Grêmio conta pro Inter
    final grenal = jogosMock.firstWhere((j) => j.timeCasa == 'Grêmio');
    expect(grenal.golsCasa, 1);
    expect(grenal.golsFora, 1);
  });

  test('jogo sobrevive à ida e volta pro formato do Firestore', () {
    for (final original in jogosMock) {
      final copia = Jogo.fromMap(original.toMap());
      expect(copia.timeCasa, original.timeCasa);
      expect(copia.status, original.status);
      expect(copia.golsCasa, original.golsCasa);
      expect(copia.golsFora, original.golsFora);
      expect(copia.eventos.length, original.eventos.length);
      expect(copia.todasEstatisticas.length, original.todasEstatisticas.length);
    }

    final time = TimeTabela.fromMap(classificacaoMock.first.toMap());
    expect(time.nome, 'Palmeiras');
    expect(time.pontos, 62);
  });
}
