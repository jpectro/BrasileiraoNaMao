class TimeTabela {
  final String nome;
  final int pontos;
  final int jogos;
  final int vitorias;
  final int saldo;

  TimeTabela({
    required this.nome,
    required this.pontos,
    required this.jogos,
    required this.vitorias,
    required this.saldo,
  });

  factory TimeTabela.fromMap(Map<String, dynamic> m) => TimeTabela(
        nome: m['nome'],
        pontos: (m['pontos'] as num).toInt(),
        jogos: (m['jogos'] as num).toInt(),
        vitorias: (m['vitorias'] as num).toInt(),
        saldo: (m['saldo'] as num).toInt(),
      );

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'pontos': pontos,
        'jogos': jogos,
        'vitorias': vitorias,
        'saldo': saldo,
      };
}
