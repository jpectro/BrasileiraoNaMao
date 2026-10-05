enum TipoEvento { gol, golPenalti, golContra, cartaoAmarelo, cartaoVermelho, substituicao }

class EventoPartida {
  final int minuto;
  final TipoEvento tipo;
  final String jogador;
  final bool doMandante;
  final String? detalhe;

  const EventoPartida({
    required this.minuto,
    required this.tipo,
    required this.jogador,
    required this.doMandante,
    this.detalhe,
  });

  factory EventoPartida.fromMap(Map<String, dynamic> m) => EventoPartida(
        minuto: (m['minuto'] as num).toInt(),
        tipo: TipoEvento.values.byName(m['tipo']),
        jogador: m['jogador'],
        doMandante: m['doMandante'],
        detalhe: m['detalhe'],
      );

  Map<String, dynamic> toMap() => {
        'minuto': minuto,
        'tipo': tipo.name,
        'jogador': jogador,
        'doMandante': doMandante,
        'detalhe': detalhe,
      };

  bool get ehGol =>
      tipo == TipoEvento.gol || tipo == TipoEvento.golPenalti || tipo == TipoEvento.golContra;

  // gol contra conta pro adversário
  bool get contaParaMandante => tipo == TipoEvento.golContra ? !doMandante : doMandante;
}
