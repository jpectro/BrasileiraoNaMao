import 'estatistica.dart';
import 'evento_partida.dart';

enum StatusJogo { agendado, aoVivo, intervalo, encerrado }

class Jogo {
  final int rodada;
  final String timeCasa;
  final String timeFora;
  final StatusJogo status;
  final int? minuto;
  final String horario;
  final String estadio;
  final List<EventoPartida> eventos;
  final List<Estatistica> estatisticas;

  Jogo({
    required this.rodada,
    required this.timeCasa,
    required this.timeFora,
    required this.status,
    required this.horario,
    required this.estadio,
    this.minuto,
    this.eventos = const [],
    this.estatisticas = const [],
  });

  // placar sai dos eventos, assim nunca fica inconsistente
  int get golsCasa => eventos.where((e) => e.ehGol && e.contaParaMandante).length;
  int get golsFora => eventos.where((e) => e.ehGol && !e.contaParaMandante).length;

  bool get aoVivo => status == StatusJogo.aoVivo || status == StatusJogo.intervalo;
  bool get comecou => status != StatusJogo.agendado;

  String get tempoJogo => switch (status) {
        StatusJogo.aoVivo => "$minuto'",
        StatusJogo.intervalo => 'Intervalo',
        StatusJogo.encerrado => 'Encerrado',
        StatusJogo.agendado => horario,
      };

  List<Estatistica> get todasEstatisticas {
    if (!comecou) return [];

    int contar(TipoEvento tipo, bool mandante) =>
        eventos.where((e) => e.tipo == tipo && e.doMandante == mandante).length;

    return [
      ...estatisticas,
      Estatistica(
        nome: 'Cartões amarelos',
        casa: contar(TipoEvento.cartaoAmarelo, true),
        fora: contar(TipoEvento.cartaoAmarelo, false),
      ),
      Estatistica(
        nome: 'Cartões vermelhos',
        casa: contar(TipoEvento.cartaoVermelho, true),
        fora: contar(TipoEvento.cartaoVermelho, false),
      ),
    ];
  }
}
