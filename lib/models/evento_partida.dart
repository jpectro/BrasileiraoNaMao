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

  bool get ehGol =>
      tipo == TipoEvento.gol || tipo == TipoEvento.golPenalti || tipo == TipoEvento.golContra;

  // gol contra conta pro adversário
  bool get contaParaMandante => tipo == TipoEvento.golContra ? !doMandante : doMandante;
}
