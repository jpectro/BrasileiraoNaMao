class Estatistica {
  final String nome;
  final int casa;
  final int fora;
  final bool percentual;

  const Estatistica({
    required this.nome,
    required this.casa,
    required this.fora,
    this.percentual = false,
  });

  factory Estatistica.fromMap(Map<String, dynamic> m) => Estatistica(
        nome: m['nome'],
        casa: (m['casa'] as num).toInt(),
        fora: (m['fora'] as num).toInt(),
        percentual: m['percentual'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'casa': casa,
        'fora': fora,
        'percentual': percentual,
      };

  bool get zerada => casa + fora == 0;

  double get proporcaoCasa => zerada ? 0 : casa / (casa + fora);
  double get proporcaoFora => zerada ? 0 : fora / (casa + fora);

  String formatar(int valor) => percentual ? '$valor%' : '$valor';
}
